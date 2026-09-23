import 'package:map_converter/src/builder/value_expression_factory/implementation/int.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class $IntExpressionFactory()', () {
    var expressionFactory = IntExpressionFactory();
    var propertyName = 'ageInDays';
    test('supports(int) should return Supported', () {
      expressionFactory.supports(TypeFake.int()).should.beOfType<Supported>();
    });
    test('supports(int?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.int(nullable: true))
          .should
          .beOfType<Supported>();
    });
    test('supports(double) should return NotSupported', () {
      expressionFactory
          .supports(TypeFake.double())
          .should
          .beOfType<NotSupported>();
    });
    test('fromMapValue, nullable=false', () {
      expressionFactory
          .fromMapValue(idFactory,
              mapValueExpression(mapVariableName, propertyName), TypeFake.int())
          .toUnFormattedString()
          .should
          .be("($mapVariableName['$propertyName'] as num ).toInt()");
    });
    test('fromMapValue, nullable=true', () {
      expressionFactory
          .fromMapValue(
              idFactory,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.int(nullable: true))
          .toUnFormattedString()
          .should
          .be("($mapVariableName['$propertyName'] as num? )?.toInt()");
    });
    test('toMapValue nullable=false', () {
      expressionFactory
          .toMapValue(
              idFactory,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.int())
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName");
    });
    test('toMapValue nullable=true', () {
      expressionFactory
          .toMapValue(
              idFactory,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.int(nullable: true))
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName");
    });
  });
}
