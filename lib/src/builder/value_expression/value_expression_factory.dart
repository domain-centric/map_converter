import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:recase/recase.dart';

/// Creates a Dart code expressions for a generated MapConverter
abstract class ValueExpressionFactory {
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert);

  /// Creates a Dart code expressions for a generated MapConverter
  /// to convert a [SimplifiedMapValue] to an object
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,

    /// [source]: An expression of the source data, e.g.:
    /// * personMap['propertyName'] (a [SimplifiedMapValue] within a [Map])
    /// * e (for an element in a collection)
    /// * k (for a key value in a [Map])
    /// * v (for a value in a [Map])
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  });

  /// Creates a Dart code expressions for a generated MapConverter
  /// to convert a [source] object to a [SimplifiedMapValue]
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,

    /// [source]: An expression of the source data, e.g.:
    /// * person.name (a field or property value of an object)
    /// * e (for an element in a collection)
    /// * k (for a key value in a [Map])
    /// * v (for a value in a [Map])
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  });
}

/// By convention, a [SimplifiedMap] map:
/// * Has key values that are none empty [String]s, much like dart method names
/// * Has a limited set of values types, see [SimplifiedMapValue]
class SimplifiedMapValue {
  //only used as documentation
}

/// By convention, a [SimplifiedMapValue] should only be one of the following:
/// * null
/// * [bool]
/// * [int]
/// * [num]
/// * [String]
/// * [List] with only of the types above
/// * [Map] see [SimplifiedMap]
class SimplifiedMap {
  //only used as documentation
}

/// Supported basic types from dart core library:
/// * BigInt
/// * bool
/// * DateTime
/// * double
/// * Duration
/// * Enum
/// * int
/// * Iterable
/// * List
/// * Map
/// * num
/// * Object (containing one or more properties of the other kind)
/// * Set
/// * String
/// * Uri
class ValueExpressionFactories extends DelegatingList<ValueExpressionFactory> {
  ValueExpressionFactories.basic()
      : super([
          BoolExpressionFactory(),
          NumExpressionFactory(),
          IntExpressionFactory(),
          DoubleExpressionFactory(),
          StringExpressionFactory(),
          UriExpressionFactory(),
          BigIntExpressionFactory(),
          DateTimeExpressionFactory(),
          DurationExpressionFactory(),
          EnumExpressionFactory(),
          DomainObjectExpressionFactory(),
        ]);

  ValueExpressionFactories.collection()
      : super([
          ListExpressionFactory(),
        ]);

  ValueExpressionFactories.all()
      : super([
          ...ValueExpressionFactories.basic(),
          ...ValueExpressionFactories.collection(),
        ]);

  ValueExpressionFactory? findFor(
          InterfaceElement classElement, InterfaceType typeToConvert) =>
      firstWhereOrNull((valueExpressionFactory) =>
          valueExpressionFactory.canConvert(classElement, typeToConvert));

  bool supports(InterfaceElement classElement, InterfaceType typeToConvert) =>
      findFor(classElement, typeToConvert) != null;
}

class BoolExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreBool;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
          MapConverterLibraryAssetIdFactory idFactory,
          ClassElement classElement,
          code.Expression source,
          InterfaceType sourceType,
          {required bool nullable}) =>
      source.asA(code.Type.ofBool(nullable: nullable));
}

class NumExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreNum;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
          MapConverterLibraryAssetIdFactory idFactory,
          ClassElement classElement,
          code.Expression source,
          InterfaceType sourceType,
          {required bool nullable}) =>
      source.asA(code.Type.ofNum(nullable: nullable));
}

class IntExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreInt;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
          MapConverterLibraryAssetIdFactory idFactory,
          ClassElement classElement,
          code.Expression source,
          InterfaceType sourceType,
          {required bool nullable}) =>
      source.asA(code.Type.ofInt(nullable: nullable));
}

class DoubleExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreDouble;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
          MapConverterLibraryAssetIdFactory idFactory,
          ClassElement classElement,
          code.Expression source,
          InterfaceType sourceType,
          {required bool nullable}) =>
      code.Expression.betweenParentheses(
              source.asA(code.Type.ofNum(nullable: nullable)))
          .callMethod('toDouble', ifNullReturnNull: nullable);
}

class StringExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreString;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(
          MapConverterLibraryAssetIdFactory idFactory,
          ClassElement classElement,
          code.Expression source,
          InterfaceType sourceType,
          {required bool nullable}) =>
      source.asA(code.Type.ofString(nullable: nullable));
}

class UriExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) {
    return typeToConvert.getDisplayString(withNullability: false) == 'Uri' &&
        typeToConvert.element2.library.name == 'dart.core';
  }

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.callMethod('toString', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
      MapConverterLibraryAssetIdFactory idFactory,
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
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
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'BigInt' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.callMethod('toString', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
      MapConverterLibraryAssetIdFactory idFactory,
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
    var result = code.Expression.ofType(code.Type.ofBigInt()).callMethod(
        'parse',
        parameterValues: code.ParameterValues(
            [code.ParameterValue(source.asA(code.Type.ofString()))]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}

class DateTimeExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'DateTime' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.callMethod('toIso8601String', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
      MapConverterLibraryAssetIdFactory idFactory,
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
    var result = code.Expression.ofType(code.Type.ofDateTime()).callMethod(
        'parse',
        parameterValues: code.ParameterValues(
            [code.ParameterValue(source.asA(code.Type.ofString()))]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}

class DurationExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'Duration' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.getProperty('inMicroseconds', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
      MapConverterLibraryAssetIdFactory idFactory,
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
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
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.element2.toString().startsWith('enum ');

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    ClassElement classElement,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.getProperty('name', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
      MapConverterLibraryAssetIdFactory idFactory,
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
    var result = code.Expression.ofType(_createType(sourceType, false))
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
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      classElement == typeToConvert.element2 // prevent endless round trips
      ||
      domainClassFactory
          .isDomainClassWithSupportedPropertyTypes(typeToConvert.element2);

  @override
  code.Expression mapValueToObject(
      MapConverterLibraryAssetIdFactory idFactory,
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
    var functionName =
        'mapTo${sourceType.getDisplayString(withNullability: false)}';
    var result = code.Expression.callMethodOrFunction(functionName,
        libraryUri: idFactory.createOutputUriForType(sourceType),
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
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
    var functionName =
        '${sourceType.getDisplayString(withNullability: false).camelCase}ToMap';
    var sourceIsProperty =
        code.CodeFormatter().unFormatted(source).contains('.');
    var result = code.Expression.callMethodOrFunction(functionName,
        libraryUri: idFactory.createOutputUriForType(sourceType),
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
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) {
    if (!typeToConvert.isDartCoreList) {
      return false;
    }
    var genericType = _genericType(typeToConvert);
    return classElement == genericType.element2 // prevent endless round trips
        ||
        basicValueExpressionFactories.supports(classElement, genericType);
  }

  @override
  code.Expression mapValueToObject(
      MapConverterLibraryAssetIdFactory idFactory,
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
    var genericType = _genericType(sourceType);

    var valueExpressionFactory =
        basicValueExpressionFactories.findFor(classElement, genericType)!;
    var valueExpression = valueExpressionFactory.mapValueToObject(
      idFactory,
      classElement,
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
      ClassElement classElement,
      code.Expression source,
      InterfaceType sourceType,
      {required bool nullable}) {
    var genericType = _genericType(sourceType);

    var valueExpressionFactory =
        basicValueExpressionFactories.findFor(classElement, genericType)!;
    var elementVariable = code.Expression.ofVariable(_listElementVariableName);
    var valueExpression = valueExpressionFactory.objectToMapValue(
      idFactory,
      classElement,
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
                _createType(genericType, nullable),
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

  InterfaceType _genericType(InterfaceType listType) =>
      listType.typeArguments.first as InterfaceType;
}

code.Type _createType(InterfaceType interfaceType, bool nullable) {
  String? libraryUri = interfaceType.element2.librarySource.uri.toString();
  if (libraryUri == 'dart:core') {
    libraryUri = null;
  }
  return code.Type(interfaceType.getDisplayString(withNullability: false),
      libraryUri: libraryUri, nullable: nullable);
}
