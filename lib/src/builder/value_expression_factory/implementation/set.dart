import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/annotation.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class SetExpressionFactory implements ValueExpressionFactory {
  final codeFormatter = code.CodeFormatter();
  final String _listElementVariableName = 'setElement';

  @override
  SupportResult supports(
      InterfaceType typeToConvert, Property? propertyAnnotation) {
    if (!typeToConvert.isDartCoreSet) {
      return NotSupported();
    }
    var genericType = _genericType(typeToConvert);
    if (genericType is! InterfaceType) {
      return NotSupported();
    }
    var queries = {Query(genericType)};

    return SupportedIfQueriesAreSupported(queries);
  }

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert,
  ) {
    var nullable = isNullable(typeToConvert);
    var genericType = _genericType(typeToConvert) as InterfaceType;
    var query = Query(genericType);
    var valueExpressionFactory = ValueExpressionFactories().findFor(query)!;
    var valueExpression = valueExpressionFactory.mapValueToObject(
      idFactory,
      property,
      code.Expression.ofVariable(_listElementVariableName),
      genericType,
    );

    return source
        .callMethod(
          'map',
          ifNullReturnNull: nullable,
          parameterValues: code.ParameterValues([
            code.ParameterValue(code.Expression([
              code.Code('($_listElementVariableName) => '),
              valueExpression,
            ]))
          ]),
        )
        .callMethod('toSet')
        .callMethod(
          'cast',
          genericType: createType(genericType.element, isNullable(genericType)),
        );
  }

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert,
  ) {
    var genericType = _genericType(typeToConvert) as InterfaceType;
    var query = Query(genericType);
    var valueExpressionFactory = ValueExpressionFactories().findFor(query)!;
    var elementVariable = code.Expression.ofVariable(_listElementVariableName);
    var valueExpression = valueExpressionFactory.objectToMapValue(
      idFactory,
      property,
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
                code.Code(' $_listElementVariableName) => '),
                valueExpression,
              ]))
            ]),
          )
          .callMethod('toSet');
    }
    return expression;
  }

  bool _needsMapping(source, valueExpression) =>
      codeFormatter.unFormatted(source) !=
      codeFormatter.unFormatted(valueExpression);

  DartType _genericType(InterfaceType listType) => listType.typeArguments.first;
}
