import 'package:map_converter/src/builder/value_expression_factory/implementation/num.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class $NumExpressionFactory()', () {
    var expressionFactory = NumExpressionFactory();
    var propertyName = 'ageInDays';
    test('supports(num) should return Supported', () {
      expressionFactory.supports(TypeFake.num()).should.beOfType<Supported>();
    });
    test('supports(num?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.num(nullable: true))
          .should
          .beOfType<Supported>();
    });
    test('supports(int) should return NotSupported', () {
      expressionFactory
          .supports(TypeFake.int())
          .should
          .beOfType<NotSupported>();
    });
    test('fromMapValuenullable=false', () {
      expressionFactory
          .fromMapValue(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.num(),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as num ");
    });
    test('fromMapValuenullable=true', () {
      expressionFactory
          .fromMapValue(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.num(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as num? ");
    });
    test('toMapValue nullable=false', () {
      expressionFactory
          .toMapValue(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.num(),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName");
    });
    test('toMapValue nullable=true', () {
      expressionFactory
          .toMapValue(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.num(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName");
    });
  });
}
