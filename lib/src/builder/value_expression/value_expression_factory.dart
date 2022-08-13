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
          ParsableTypeExpressionFactory(Uri),
          ParsableTypeExpressionFactory(BigInt),
        ]);
}

/// Generic [ValueExpressionFactory] for basic Dart types
class BasicTypeExpressionFactory implements ValueExpressionFactory {
  final Type basicType;

  BasicTypeExpressionFactory(this.basicType);

  @override
  bool canConvert(Type typeToConvert) => typeToConvert == basicType;

  @override
  code.Expression createToMapValueCode(
          String instanceVariableName, String propertyName,
          {required bool nullable}) =>
      code.Expression.ofVariable(instanceVariableName)
          .getProperty(propertyName);

  @override
  code.Expression createToObjectPropertyValueCode(
          String mapVariableName, String propertyName,
          {required bool nullable}) =>
      code.Expression([code.Code("$mapVariableName['$propertyName']")])
          .asA(_typeExpression(nullable: nullable));

  code.Expression _typeExpression({required bool nullable}) => code.Expression(
      [code.Code(basicType.toString()), if (nullable) code.Code('?')]);
}

class DoubleExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(Type typeToConvert) => typeToConvert == double;

  @override
  code.Expression createToMapValueCode(
          String instanceVariableName, String propertyName,
          {required bool nullable}) =>
      code.Expression.ofVariable(instanceVariableName)
          .getProperty(propertyName);

  @override
  code.Expression createToObjectPropertyValueCode(
          String mapVariableName, String propertyName,
          {required bool nullable}) =>
      code.Expression([
        code.Code("("),
        code.Code("$mapVariableName['$propertyName']"),
        if (nullable) code.Code(' as num?)?.toDouble()'),
        if (!nullable) code.Code(' as num).toDouble()'),
      ]);
}

/// Generic [ValueExpressionFactory] for basic parsable Dart types such as [Uri] and [BigInt]
class ParsableTypeExpressionFactory extends ValueExpressionFactory {
  final Type parsableType;

  ParsableTypeExpressionFactory(this.parsableType);

  @override
  bool canConvert(Type typeToConvert) => typeToConvert == parsableType;

  @override
  code.Expression createToMapValueCode(
          String instanceVariableName, String propertyName,
          {required bool nullable}) =>
      code.Expression([
        code.Code(
            '$instanceVariableName.$propertyName${nullable ? '?' : ''}.toString()')
      ]);

  @override
  code.Expression createToObjectPropertyValueCode(
          String mapVariableName, String propertyName,
          {required bool nullable}) =>
      code.Expression([
        if (nullable)
          code.Code("$mapVariableName['$propertyName'] == null ? null : "),
        code.Code("$parsableType.parse($mapVariableName['$propertyName'] as String)"),
      ]);
}
