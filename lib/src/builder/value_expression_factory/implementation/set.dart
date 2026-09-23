import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class SetExpressionFactory implements ValueExpressionFactory {
  final String _elementVariableName = 'setElement';

  @override
  SupportResult supports(InterfaceType typeToConvert) {
    if (!typeToConvert.isDartCoreSet) {
      return NotSupported();
    }
    var genericType = _genericType(typeToConvert);
    if (genericType is! InterfaceType) {
      return NotSupported();
    }
    var typesThatMustBeSupported = {genericType};

    return SupportedIfTypesAreSupported(typesThatMustBeSupported);
  }

  bool _needsMapping(code.CodeModel source, code.CodeModel valueExpression) =>
      source.toUnFormattedString() != valueExpression.toUnFormattedString();

  DartType _genericType(InterfaceType listType) => listType.typeArguments.first;

  @override
  FromMapValueExpressionFunction get fromMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var nullable = isNullable(typeToConvert);
        var genericType = _genericType(typeToConvert) as InterfaceType;
        var valueExpressionFactory =
            ValueExpressionFactories().findFor(genericType)!;
        var valueExpression = valueExpressionFactory.fromMapValue(
          idFactory,
          code.Expression.ofVariable(_elementVariableName),
          genericType,
        );

        return source
            .callMethod(
              'map',
              ifNullReturnNull: nullable,
              parameterValues: code.ParameterValues([
                code.ParameterValue(code.Expression([
                  code.Code('($_elementVariableName) => '),
                  valueExpression,
                ]))
              ]),
            )
            .callMethod('toSet')
            .callMethod(
              'cast',
              genericType:
                  createType(genericType.element, isNullable(genericType)),
            );
      };

  @override
  ToMapValueExpressionFunction get toMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var genericType = _genericType(typeToConvert) as InterfaceType;
        var valueExpressionFactory =
            ValueExpressionFactories().findFor(genericType)!;
        var elementVariable = code.Expression.ofVariable(_elementVariableName);
        var valueExpression = valueExpressionFactory.toMapValue(
          idFactory,
          elementVariable,
          genericType,
        );

        var expression = source;
        if (_needsMapping(elementVariable, valueExpression)) {
          var nullable = isNullable(typeToConvert);
          expression = expression
              .callMethod(
                'map',
                ifNullReturnNull: nullable,
                parameterValues: code.ParameterValues([
                  code.ParameterValue(code.Expression([
                    code.Code('('),
                    createType(genericType.element, isNullable(genericType)),
                    code.Code(' $_elementVariableName) => '),
                    valueExpression,
                  ]))
                ]),
              )
              .callMethod('toSet');
        }
        return expression;
      };
}
