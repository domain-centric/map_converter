import 'package:map_converter/src/builder/value_expression_factory/implementation/string.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class: $StringExpressionFactory', () {
    var expressionFactory = StringExpressionFactory();
    var propertyName = 'name';
    test('supports(String) should return Supported', () {
      expressionFactory
          .supports(TypeFake.string())
          .should
          .beOfType<Supported>();
    });
    test('supports(String?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.string(nullable: true))
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
            TypeFake.string(),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as String ");
    });
    test('fromMapValuenullable=true', () {
      expressionFactory
          .fromMapValue(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.string(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as String? ");
    });
    test('toMapValue nullable=false', () {
      expressionFactory
          .toMapValue(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.string(),
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
            TypeFake.string(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName");
    });
  });
}
