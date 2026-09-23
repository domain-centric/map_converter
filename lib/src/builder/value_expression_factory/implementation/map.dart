import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class MapExpressionFactory implements ValueExpressionFactory {
  final String _keyVariableName = 'k';
  final String _valueVariableName = 'v';

  @override
  SupportResult supports(InterfaceType typeToConvert) {
    if (!typeToConvert.isDartCoreMap) {
      return NotSupported();
    }
    var keyType = _keyType(typeToConvert);
    var valueType = _valueType(typeToConvert);
    if (keyType is! InterfaceType || valueType is! InterfaceType) {
      return NotSupported();
    }
    var typesThatMustBeSupported = {keyType, valueType};
    return SupportedIfTypesAreSupported(typesThatMustBeSupported);
  }

  code.Expression _createFromMapValueExpression(
    MapConverterLibraryAssetIdFactory idFactory,
    String variableName,
    InterfaceType typeToConvert,
  ) {
    var expressionFactory = ValueExpressionFactories().findFor(typeToConvert)!;
    var expression = expressionFactory.fromMapValue(
      idFactory,
      code.Expression.ofVariable(variableName),
      typeToConvert,
    );
    var unformattedCode = expression.toUnFormattedString().trim();
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
  ) =>
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

  code.Expression _createToMapValueExpression(
    MapConverterLibraryAssetIdFactory idFactory,
    String variableName,
    InterfaceType typeToConvert,
  ) {
    var expressionFactory = ValueExpressionFactories().findFor(typeToConvert);
    return expressionFactory!.toMapValue(
      idFactory,
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

  bool _needsConversion(code.Expression expression, String mapVariableName) =>
      expression.toUnFormattedString() != mapVariableName;

  @override
  FromMapValueExpressionFunction get fromMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var nullable = isNullable(typeToConvert);
        var keyType = _keyType(typeToConvert) as InterfaceType;
        var keyExpression =
            _createFromMapValueExpression(idFactory, _keyVariableName, keyType);
        var keyNeedsConversion =
            _needsConversion(keyExpression, _keyVariableName);

        var valueType = _valueType(typeToConvert) as InterfaceType;
        var valueExpression = _createFromMapValueExpression(
            idFactory, _valueVariableName, valueType);
        var valueNeedsConversion =
            _needsConversion(valueExpression, _valueVariableName);

        if (isNullable(typeToConvert) ||
            keyNeedsConversion ||
            valueNeedsConversion) {
          return _createMapToObjectExpressionWithMapping(source, nullable,
              keyType, keyExpression, valueType, valueExpression);
        } else {
          return _createMapToObjectExpression(source, keyType, valueType);
        }
      };

  @override
  ToMapValueExpressionFunction get toMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var keyType = _keyType(typeToConvert) as InterfaceType;
        var keyExpression =
            _createToMapValueExpression(idFactory, _keyVariableName, keyType);
        var keyNeedsConversion =
            _needsConversion(keyExpression, _keyVariableName);

        var valueType = _valueType(typeToConvert) as InterfaceType;
        var valueExpression = _createToMapValueExpression(
            idFactory, _valueVariableName, valueType);
        var valueNeedsConversion =
            _needsConversion(valueExpression, _valueVariableName);

        if (keyNeedsConversion || valueNeedsConversion) {
          var nullable = isNullable(typeToConvert);
          return _createObjectToMapExpressionWithMapping(source, nullable,
              keyType, keyExpression, valueType, valueExpression);
        } else {
          return _createObjectToMapExpression(source);
        }
      };
}
