import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;

/// Creates a Dart code expressions for a generated MapConverter
abstract class ValueExpressionFactory {
  bool canConvert(Type typeToConvert);

  /// Creates a Dart code expressions for a generated MapConverter
  /// to set a property value of an object property from a map variable
  code.Expression createToObjectPropertyValueCode(
      String mapVariableName, String propertyName,
      {required bool nullable});

  /// Creates a Dart code expressions for a generated MapConverter
  /// to set a map value from an object property
  code.Expression createToMapValueCode(
      String instanceVariableName, String propertyName,
      {required bool nullable});
}

/// Supported types from dart core library: BigInt, bool, DateTime, double, Duration, Enum, int, Iterable, List, Map, num, Object, Set, String, Uri

class ValueExpressionFactories extends DelegatingList<ValueExpressionFactory> {
  ValueExpressionFactories()
      : super([
          BasicTypeExpressionFactory(String),
          BasicTypeExpressionFactory(num),
          BasicTypeExpressionFactory(int),
          BasicTypeExpressionFactory(bool),
          DoubleExpressionFactory(),
          UriExpressionFactory(),
          BigIntExpressionFactory(),
          DateTimeExpressionFactory(),
          DurationExpressionFactory(),
        ]);
}

/// Generic [ValueExpressionFactory] for basic parsable Dart types such as [Uri] and [BigInt]
class BasicTypeExpressionFactory extends ValueExpressionFactory {
  final Type propertyType;

  BasicTypeExpressionFactory(this.propertyType);

  @override
  bool canConvert(Type typeToConvert) => typeToConvert == propertyType;

  @override
  code.Expression createToMapValueCode(
          String instanceVariableName, String propertyName,
          {required bool nullable}) =>
      code.Expression([
        code.Code(nullable
            ? createToMapNullableValueCodeString(
                instanceVariableName, propertyName)
            : createToMapValueCodeString(instanceVariableName, propertyName))
      ]);

  @override
  code.Expression createToObjectPropertyValueCode(
          String mapVariableName, String propertyName,
          {required bool nullable}) =>
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

  String createToObjectPropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as $propertyType";

  String createToObjectNullablePropertyValueCodeString(
          String mapVariableName, String propertyName) =>
      "$mapVariableName['$propertyName'] as $propertyType?";
}

class DoubleExpressionFactory extends BasicTypeExpressionFactory {
  DoubleExpressionFactory() : super(double);

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
  UriExpressionFactory() : super(Uri);

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
  BigIntExpressionFactory() : super(BigInt);

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
  DateTimeExpressionFactory() : super(DateTime);

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
  DurationExpressionFactory() : super(Duration);

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
