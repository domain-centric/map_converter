import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class ListExpressionFactory implements ValueExpressionFactory {
  final basicValueExpressionFactories = ValueExpressionFactories.basic();
  final codeFormatter = code.CodeFormatter();
  final String _listElementVariableName = 'listElement';

  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) {
    if (!typeToConvert.isDartCoreList) {
      return false;
    }
    var genericType = _genericType(typeToConvert);
    if (genericType is! InterfaceType) {
      return false;
    }
    return classElement == genericType.element // prevent endless round trips
        ||
        basicValueExpressionFactories.supports(
            propertyAnnotation, classElement, genericType);
  }

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var genericType = _genericType(typeToConvert) as InterfaceType;

    var valueExpressionFactory = basicValueExpressionFactories.findFor(
        property, property.classElement, genericType)!;
    var valueExpression = valueExpressionFactory.mapValueToObject(
      idFactory,
      property,
      code.Expression.ofVariable(_listElementVariableName),
      genericType,
      nullable: nullable,
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
        .callMethod('toList');
  }

  @override
  code.Expression objectToMapValue(
      MapConverterLibraryAssetIdFactory idFactory,
      PropertyWithBuildInfo property,
      code.Expression source,
      InterfaceType typeToConvert,
      {required bool nullable}) {
    var genericType = _genericType(typeToConvert) as InterfaceType;

    var valueExpressionFactory = basicValueExpressionFactories.findFor(
        property, property.classElement, genericType)!;
    var elementVariable = code.Expression.ofVariable(_listElementVariableName);
    var valueExpression = valueExpressionFactory.objectToMapValue(
      idFactory,
      property,
      elementVariable,
      genericType,
      nullable: nullable,
    );

    var expression = source;
    if (_needsMapping(elementVariable, valueExpression)) {
      expression = expression
          .callMethod(
            'map',
            ifNullReturnNull: nullable,
            parameterValues: code.ParameterValues([
              code.ParameterValue(code.Expression([
                code.Code('('),
                createType(genericType.element, nullable),
                code.Code(' $_listElementVariableName) => '),
                valueExpression,
              ]))
            ]),
          )
          .callMethod('toList');
    }
    return expression;
  }

  bool _needsMapping(source, valueExpression) =>
      codeFormatter.unFormatted(source) !=
      codeFormatter.unFormatted(valueExpression);

  DartType _genericType(InterfaceType listType) => listType.typeArguments.first;
}

