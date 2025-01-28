import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:recase/recase.dart';

class BoolExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.isDartCoreBool;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
          MapConverterLibraryAssetIdFactory idFactory,
          PropertyWithBuildInfo property,
          code.Expression source,
          InterfaceType typeToConvert,
          {required bool nullable}) =>
      source.asA(code.Type.ofBool(nullable: nullable));
}

class NumExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.isDartCoreNum;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.asA(code.Type.ofNum(nullable: nullable));
}

class IntExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.isDartCoreInt;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.asA(code.Type.ofInt(nullable: nullable));
}

class DoubleExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.isDartCoreDouble;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      code.Expression.betweenParentheses(
              source.asA(code.Type.ofNum(nullable: nullable)))
          .callMethod('toDouble', ifNullReturnNull: nullable);
}

class StringExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.isDartCoreString;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.asA(code.Type.ofString(nullable: nullable));
}

class UriExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.getDisplayString(withNullability: false) == 'Uri' &&
      typeToConvert.element.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.callMethod('toString', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var result = code.Expression.ofType(code.Type.ofUri()).callMethod('parse',
        parameterValues: code.ParameterValues(
            [code.ParameterValue(source.asA(code.Type.ofString()))]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}

code.Expression _wrapWithIfNullWhenNullable(
    bool nullable, code.Expression source, code.Expression result) {
  if (nullable) {
    return source
        .equalTo(code.Expression.ofNull())
        .conditional(code.Expression.ofNull(), result);
  } else {
    return result;
  }
}

class BigIntExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.getDisplayString(withNullability: false) == 'BigInt' &&
      typeToConvert.element.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.callMethod('toString', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var result = code.Expression.ofType(code.Type.ofBigInt()).callMethod(
        'parse',
        parameterValues: code.ParameterValues(
            [code.ParameterValue(source.asA(code.Type.ofString()))]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}

class DateTimeExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.getDisplayString(withNullability: false) == 'DateTime' &&
      typeToConvert.element.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.callMethod('toIso8601String', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var result = code.Expression.ofType(code.Type.ofDateTime()).callMethod(
        'parse',
        parameterValues: code.ParameterValues(
            [code.ParameterValue(source.asA(code.Type.ofString()))]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}

class DurationExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.getDisplayString(withNullability: false) == 'Duration' &&
      typeToConvert.element.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.getProperty('inMicroseconds', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var result = code.Expression.callConstructor(code.Type.ofDuration(),
        parameterValues: code.ParameterValues([
          code.ParameterValue.named(
              'microseconds', source.asA(code.Type.ofInt()))
        ]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}

class EnumExpressionFactory implements ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.element.toString().startsWith('enum ');

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.getProperty('name', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var propertyType = createType(typeToConvert.element, false);
    var result = code.Expression.ofType(propertyType)
        .getProperty('values')
        .callMethod('firstWhere',
            parameterValues: code.ParameterValues(([
              code.ParameterValue(code.Expression([
                code.Code('(enumValue) => enumValue.name=='),
                source,
              ]))
            ])));

    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}


class DomainObjectExpressionFactory implements ValueExpressionFactory {
  final domainClassFactory = DomainClassFactory();

  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      classElement == typeToConvert.element // prevent endless round trips
      ||
      domainClassFactory
          .isDomainClassWithSupportedPropertyTypes(typeToConvert.element);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var functionName =
        'mapTo${typeToConvert.getDisplayString(withNullability: false)}';
    var result = code.Expression.callMethodOrFunction(functionName,
        libraryUri: createRelativeLibraryUri(
            idFactory.createOutputUriForType(typeToConvert)),
        parameterValues: code.ParameterValues([
          code.ParameterValue(source.asA(code.Type.ofMap(
            keyType: code.Type.ofString(),
            valueType: code.Type.ofDynamic(),
          )))
        ]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var functionName =
        '${typeToConvert.getDisplayString(withNullability: false).camelCase}ToMap';
    var sourceIsProperty =
        code.CodeFormatter().unFormatted(source).contains('.');
    var result = code.Expression.callMethodOrFunction(functionName,
        libraryUri: createRelativeLibraryUri(
            idFactory.createOutputUriForType(typeToConvert)),
        parameterValues: code.ParameterValues([
          code.ParameterValue(code.Expression([
            source,
            if (nullable && sourceIsProperty) code.Code('!'),
          ]))
        ]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}

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

