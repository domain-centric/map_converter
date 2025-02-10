import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class MapExpressionFactory implements ValueExpressionFactory {
  final codeFormatter = code.CodeFormatter();
  final String _keyVariableName = 'k';
  final String _valueVariableName = 'v';

  @override
  SupportResult supports(
      InterfaceType typeToConvert, Property? propertyAnnotation) {
    if (!typeToConvert.isDartCoreMap) {
      return NotSupported();
    }
    var keyType = _keyType(typeToConvert);
    var valueType = _valueType(typeToConvert);
    if (keyType is! InterfaceType || valueType is! InterfaceType) {
      return NotSupported();
    }
    var queries = {Query(keyType), Query(valueType)};
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
    var keyType = _keyType(typeToConvert) as InterfaceType;
    var keyExpression = _createMapValueToObjectExpression(
        idFactory, property, _keyVariableName, keyType);
    var keyNeedsConversion = _needsConversion(keyExpression, _keyVariableName);

    var valueType = _valueType(typeToConvert) as InterfaceType;
    var valueExpression = _createMapValueToObjectExpression(
        idFactory, property, _valueVariableName, valueType);
    var valueNeedsConversion =
        _needsConversion(valueExpression, _valueVariableName);

    if (isNullable(typeToConvert) ||
        keyNeedsConversion ||
        valueNeedsConversion) {
      return _createMapToObjectExpressionWithMapping(
          source, nullable, keyType, keyExpression, valueType, valueExpression);
    } else {
      return _createMapToObjectExpression(source, keyType, valueType, property);
    }
  }

  _createMapValueToObjectExpression(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    String variableName,
    InterfaceType typeToConvert,
  ) {
    var query = Query(typeToConvert);
    var expressionFactory = ValueExpressionFactories().findFor(query)!;
    var expression = expressionFactory.mapValueToObject(
      idFactory,
      property,
      code.Expression.ofVariable(variableName),
      typeToConvert,
    );
    var unformattedCode = code.CodeFormatter().unFormatted(expression).trim();
    if (unformattedCode == '$_keyVariableName as String') {
      return code.Expression.ofVariable(_keyVariableName);
    }
    return expression;
  }

  // e.g. Map<String, int>.from(json['map'] as Map)
  code.Expression _createMapToObjectExpression(
          code.Expression source,
          InterfaceType keyType,
          InterfaceType valueType,
          PropertyWithBuildInfo property) =>
      code.Expression([
        code.Type.ofMap(
          keyType: createType(keyType.element, isNullable(keyType)),
          valueType: createType(valueType.element, isNullable(valueType)),
        )
      ]).callMethod('from',
          parameterValues: code.ParameterValues([code.ParameterValue(source)]));

// e.g. (map['property'] as Map?)?.map((k, v) => MapEntry(kExpression, vExpression)
  code.Expression _createMapToObjectExpressionWithMapping(
          code.Expression source,
          bool nullable,
          InterfaceType keyType,
          keyExpression,
          InterfaceType valueType,
          valueExpression) =>
      code.Expression([
        code.Code('('),
        source.asA(code.Type.ofMap(
          nullable: nullable,
        )),
        code.Code(')'),
      ]).callMethod('map',
          ifNullReturnNull: nullable,
          parameterValues: code.ParameterValues([
            code.ParameterValue(code.Expression([
              code.Code('('),
              code.Code(_keyVariableName),
              code.Code(','),
              code.Code(_valueVariableName),
              code.Code(')'),
              code.Code('=>'),
              code.Expression.callConstructor(code.Type('MapEntry'),
                  parameterValues: code.ParameterValues([
                    code.ParameterValue(keyExpression),
                    code.ParameterValue(valueExpression)
                  ])),
            ])),
          ]));

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert,
  ) {
    var keyType = _keyType(typeToConvert) as InterfaceType;
    var keyExpression = _createObjectToMapValueExpression(
        idFactory, property, _keyVariableName, keyType);
    var keyNeedsConversion = _needsConversion(keyExpression, _keyVariableName);

    var valueType = _valueType(typeToConvert) as InterfaceType;
    var valueExpression = _createObjectToMapValueExpression(
        idFactory, property, _valueVariableName, valueType);
    var valueNeedsConversion =
        _needsConversion(valueExpression, _valueVariableName);

    if (keyNeedsConversion || valueNeedsConversion) {
      var nullable = isNullable(typeToConvert);
      return _createObjectToMapExpressionWithMapping(
          source, nullable, keyType, keyExpression, valueType, valueExpression);
    } else {
      return _createObjectToMapExpression(source);
    }
  }

  code.Expression _createObjectToMapValueExpression(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    String variableName,
    InterfaceType typeToConvert,
  ) {
    var query = Query(typeToConvert);
    var expressionFactory = ValueExpressionFactories().findFor(query);
    return expressionFactory!.objectToMapValue(
      idFactory,
      property,
      code.Expression.ofVariable(variableName),
      typeToConvert,
    );
  }

// e.g.  mapExample.map
  code.Expression _createObjectToMapExpression(code.Expression source) =>
      source;

// e.g. myMap.map((key,value) => MapEntry(key,value))
  code.Expression _createObjectToMapExpressionWithMapping(
          code.Expression source,
          bool nullable,
          InterfaceType keyType,
          keyExpression,
          InterfaceType valueType,
          valueExpression) =>
      source.callMethod('map',
          ifNullReturnNull: nullable,
          parameterValues: code.ParameterValues([
            code.ParameterValue(code.Expression([
              code.Code('('),
              code.Code(_keyVariableName),
              code.Code(','),
              code.Code(_valueVariableName),
              code.Code(')'),
              code.Code('=>'),
              code.Expression.callConstructor(code.Type('MapEntry'),
                  parameterValues: code.ParameterValues([
                    code.ParameterValue(keyExpression),
                    code.ParameterValue(valueExpression)
                  ])),
            ]))
          ]));

  DartType _keyType(InterfaceType mapType) => mapType.typeArguments.first;
  DartType _valueType(InterfaceType mapType) => mapType.typeArguments.last;

  _needsConversion(expression, String mapVariableName) =>
      codeFormatter.unFormatted(expression) != mapVariableName;
}
