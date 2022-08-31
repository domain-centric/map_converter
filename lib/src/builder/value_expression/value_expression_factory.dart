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
  /// to set a property value of an object property from a map variable
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,

    /// [source]: An expression of the source data, e.g.:
    /// * personMap['propertyName']
    /// * e (for an element in a collection)
    /// * k (for a key value in a [Map])
    /// * v (for a value in a [Map])
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  });

  /// Creates a Dart code expressions for a generated MapConverter
  /// to set a map value from an object property
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,

    /// [source]: An expression of the source data, e.g.:
    /// * person.propertyName
    /// * e (for an element in a collection)
    /// * k (for a key value in a [Map])
    /// * v (for a value in a [Map])
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  });
}

/// Supported types from dart core library: BigInt, bool, DateTime, double, Duration, Enum, int, Iterable, List, Map, num, Object, Set, String, Uri
class ValueExpressionFactories extends DelegatingList<ValueExpressionFactory> {
  ValueExpressionFactories()
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

  ValueExpressionFactory? findFor(
          InterfaceElement classElement, InterfaceType typeToConvert) =>
      firstWhereOrNull((valueExpressionFactory) =>
          valueExpressionFactory.canConvert(classElement, typeToConvert));
}

class BoolExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreBool;

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
          code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
          code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
          code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
          code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source;

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
          code.Expression source, InterfaceType sourceType,
          {required bool nullable}) =>
      source.asA(code.Type.ofString(nullable: nullable));
}

class UriExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'Uri' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.callMethod('toString', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
      code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.callMethod('toString', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
      code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.callMethod('toIso8601String', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
      code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.getProperty('inMicroseconds', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
      code.Expression source, InterfaceType sourceType,
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
    code.Expression source,
    InterfaceType sourceType, {
    required bool nullable,
  }) =>
      source.getProperty('name', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
      code.Expression source, InterfaceType sourceType,
      {required bool nullable}) {
    var result = code.Expression.ofType(code.Type(
            sourceType.element2.displayName,
            libraryUri: sourceType.element2.librarySource.uri.toString()))
        .getProperty('values')
        .callMethod('firstWhere',
            parameterValues: code.ParameterValues(([
              code.ParameterValue(code.Expression([
                code.Code('(e) => e.name=='),
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
  code.Expression mapValueToObject(MapConverterLibraryAssetIdFactory idFactory,
      code.Expression source, InterfaceType sourceType,
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
  code.Expression objectToMapValue(MapConverterLibraryAssetIdFactory idFactory,
      code.Expression source, InterfaceType sourceType,
      {required bool nullable}) {
    var functionName =
        '${sourceType.getDisplayString(withNullability: false).camelCase}ToMap';
    var result = code.Expression.callMethodOrFunction(functionName,
        libraryUri: idFactory.createOutputUriForType(sourceType),
        parameterValues: code.ParameterValues([
          code.ParameterValue(code.Expression([
            source,
            if (nullable) code.Code('!'),
          ]))
        ]));
    return _wrapWithIfNullWhenNullable(nullable, source, result);
  }
}
