import 'package:map_converter/src/builder/value_expression_factory/implementation/date_time.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $DateTimeExpressionFactory()", () {
    var expressionFactory = DateTimeExpressionFactory();
    var propertyName = 'dateOfBirth';
    test('supports(DateTime) should return Supported', () {
      expressionFactory
          .supports(TypeFake.dateTime())
          .should
          .beOfType<Supported>();
    });

    test('supports(DateTime?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.dateTime(nullable: true))
          .should
          .beOfType<Supported>();
    });
    test('supports(int) should return NotSupported', () {
      expressionFactory
          .supports(
            TypeFake.int(),
          )
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject nullable=false', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.dateTime(),
          )
          .toUnFormattedString()
          .should
          .be("DateTime.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject nullable=true', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.dateTime(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] == null ? null : DateTime.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue nullable=false', () {
      expressionFactory
          .objectToMapValueFunction(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.dateTime(),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName.toIso8601String()");
    });
    test('objectToMapValue nullable=true', () {
      expressionFactory
          .objectToMapValueFunction(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.dateTime(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName?.toIso8601String()");
    });
  });
}
