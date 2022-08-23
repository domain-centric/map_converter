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
  code.Expression createToObjectPropertyValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String mapVariableName,
    String propertyName,
    InterfaceType propertyType, {
    required bool nullable,
  });

  /// Creates a Dart code expressions for a generated MapConverter
  /// to set a map value from an object property
  code.Expression createToMapValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String instanceVariableName,
    String propertyName,
    InterfaceType propertyType, {
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

abstract class BasicTypeExpressionFactory extends ValueExpressionFactory {
  @override
  code.Expression createToMapValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String instanceVariableName,
    String propertyName,
    InterfaceType propertyType, {
    required bool nullable,
  }) =>
      code.Expression([
        code.Code(nullable
            ? createToMapNullableValueCodeString(
                instanceVariableName, propertyName)
            : createToMapValueCodeString(instanceVariableName, propertyName))
      ]);

  @override
  code.Expression createToObjectPropertyValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String mapVariableName,
    String propertyName,
    InterfaceType propertyType, {
    required bool nullable,
  }) =>
      code.Expression([
        code.Code(nullable
            ? createToObjectNullablePropertyValueCodeString(
                mapVariableName, propertyName)
            : createToObjectPropertyValueCodeString(
                mapVariableName, propertyName))
      ]);

  String createToMapValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName';

  String createToMapNullableValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName';

  createToObjectNullablePropertyValueCodeString(
      String mapVariableName, String propertyName);

  createToObjectPropertyValueCodeString(
      String mapVariableName, String propertyName);
}

class BoolExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreBool;

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as bool";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as bool?";
}

class StringExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreString;

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as String";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as String?";
}

class NumExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreNum;

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as num";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as num?";
}

class IntExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreInt;

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as int";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as int?";
}

class DoubleExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.isDartCoreDouble;

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "($mapVariableName['$propertyName'] as num).toDouble()";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "($mapVariableName['$propertyName'] as num?)?.toDouble()";
}

class UriExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'Uri' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  String createToMapValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName.toString()';

  @override
  String createToMapNullableValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName?.toString()';

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "Uri.parse($mapVariableName['$propertyName'] as String)";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] == null "
      "? null "
      ": Uri.parse($mapVariableName['$propertyName'] as String)";
}

class BigIntExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'BigInt' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  String createToMapValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName.toString()';

  @override
  String createToMapNullableValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName?.toString()';

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "BigInt.parse($mapVariableName['$propertyName'] as String)";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] == null "
      "? null "
      ": BigInt.parse($mapVariableName['$propertyName'] as String)";
}

class DateTimeExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'DateTime' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  String createToMapValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName.toIso8601String()';

  @override
  String createToMapNullableValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName?.toIso8601String()';

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "DateTime.parse($mapVariableName['$propertyName'] as String)";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] == null "
      "? null "
      ": DateTime.parse($mapVariableName['$propertyName'] as String)";
}

class DurationExpressionFactory extends BasicTypeExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.getDisplayString(withNullability: false) == 'Duration' &&
      typeToConvert.element2.library.name == 'dart.core';

  @override
  String createToMapValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName.inMicroseconds';

  @override
  String createToMapNullableValueCodeString(
          String instanceVariableName, String propertyName) =>
      '$instanceVariableName.$propertyName?.inMicroseconds';

  @override
  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "Duration(microseconds: $mapVariableName['$propertyName'] as int)";

  @override
  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] == null "
      "? null "
      ": Duration(microseconds: $mapVariableName['$propertyName'] as int)";
}

class EnumExpressionFactory implements ValueExpressionFactory {
  @override
  bool canConvert(InterfaceElement classElement, InterfaceType typeToConvert) =>
      typeToConvert.element2.toString().startsWith('enum ');

  @override
  code.Expression createToMapValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String instanceVariableName,
    String propertyName,
    InterfaceType propertyType, {
    required bool nullable,
  }) =>
      code.Expression([
        code.Code(
            '$instanceVariableName.$propertyName${nullable ? '?' : ''}.name'),
      ]);

  @override
  code.Expression createToObjectPropertyValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String mapVariableName,
    String propertyName,
    InterfaceType propertyType, {
    required bool nullable,
  }) =>
      code.Expression([
        if (nullable)
          code.Code("$mapVariableName['$propertyName'] == null ? null : "),
        toCodeType(propertyType),
        code.Code(
            ".values.firstWhere((enumValue) => enumValue.name==$mapVariableName['$propertyName'])")
      ]);
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
  code.Expression createToMapValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String instanceVariableName,
    String propertyName,
    InterfaceType propertyType, {
    required bool nullable,
  }) =>
      code.Expression([
        if (nullable)
          code.Code("$instanceVariableName.$propertyName == null ? null : "),
        code.Expression.callFunction(
            '${propertyType.getDisplayString(withNullability: false).camelCase}ToMap',
            libraryUri: idFactory.createOutputUriForType(propertyType),
            parameterValues: code.ParameterValues([
              code.ParameterValue(code.Expression([
                code.Expression.ofVariable(instanceVariableName)
                    .getProperty(propertyName),
                if (nullable) code.Code('!'),
              ]))
            ]))
      ]);

  @override
  code.Expression createToObjectPropertyValueCode(
    MapConverterLibraryAssetIdFactory idFactory,
    String mapVariableName,
    String propertyName,
    InterfaceType propertyType, {
    required bool nullable,
  }) =>
      code.Expression([
        if (nullable)
          code.Code("$mapVariableName['$propertyName'] == null ? null : "),
        code.Expression.callFunction(
          'mapTo${propertyType.getDisplayString(withNullability: false)}',
          libraryUri: idFactory.createOutputUriForType(propertyType),
          parameterValues: code.ParameterValues([
            code.ParameterValue(code.Expression([
              code.Code(
                  "$mapVariableName['$propertyName'] as Map<String, dynamic>")
            ]))
          ]),
        )
      ]);
}

code.Type toCodeType(InterfaceType propertyType) =>
    code.Type(propertyType.element2.displayName,
        libraryUri: propertyType.element2.librarySource.toString());
