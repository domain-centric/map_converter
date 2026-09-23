import 'package:map_converter/src/builder/value_expression_factory/implementation/duration.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $DurationExpressionFactory()", () {
    var expressionFactory = DurationExpressionFactory();
    var propertyName = 'age';
    test('supports(Duration) should return Supported', () {
      expressionFactory
          .supports(TypeFake.duration())
          .should
          .beOfType<Supported>();
    });
    test('supports(Duration?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.duration(nullable: true))
          .should
          .beOfType<Supported>();
    });
    test('supports(int) should return NotSupported', () {
      expressionFactory
          .supports(TypeFake.int())
          .should
          .beOfType<NotSupported>();
    });
    test('fromMapValue, nullable=false', () {
      expressionFactory
          .fromMapValue(
              idFactory,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.duration())
          .toUnFormattedString()
          .should
          .be("Duration(microseconds: $mapVariableName['$propertyName'] as int )");
    });
    test('fromMapValue, nullable=true', () {
      expressionFactory
          .fromMapValue(
              idFactory,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.duration(nullable: true))
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] == null ? null : Duration(microseconds: $mapVariableName['$propertyName'] as int )");
    });

    test('toMapValue nullable=false', () {
      expressionFactory
          .toMapValue(
              idFactory,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.duration())
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName.inMicroseconds");
    });
    test('toMapValue nullable=true', () {
      expressionFactory
          .toMapValue(
              idFactory,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.duration(nullable: true))
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName?.inMicroseconds");
    });
  });
}
