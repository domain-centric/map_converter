import 'package:map_converter/src/builder/value_expression_factory/implementation/map.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'myMap';
  const propertyName = 'myProperty';
  const instanceVariableName = 'person';

  group("class: $MapExpressionFactory)", () {
    var expressionFactory = MapExpressionFactory();

    group("for: Map<int,String>", () {
      var keyType = TypeFake.int();
      var valueType = TypeFake.string();
      test(
          'supports(Map<int,String>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.map(keyType, valueType))
            .should
            .beOfType<SupportedIfTypesAreSupported>();
      });
      test(
          'supports(Map<int,String>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.map(keyType, valueType, nullable: true))
            .should
            .beOfType<SupportedIfTypesAreSupported>();
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
              TypeFake.map(keyType, valueType),
            )
            .toUnFormattedString()
            .should
            .be("(myMap['myProperty'] as Map ).map((k,v)=>MapEntry((k as num ).toInt(),v as String ))");
      });
      test('fromMapValuenullable=true', () {
        expressionFactory
            .fromMapValue(
              idFactory,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.map(keyType, valueType, nullable: true),
            )
            .toUnFormattedString()
            .should
            .be("(myMap['myProperty'] as Map? )?.map((k,v)=>MapEntry((k as num ).toInt(),v as String ))");
      });
      test('toMapValue nullable=false', () {
        expressionFactory
            .toMapValue(
              idFactory,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.map(keyType, valueType),
            )
            .toUnFormattedString()
            .should
            .be("person.myProperty");
      });
      test('toMapValue nullable=true', () {
        expressionFactory
            .toMapValue(
              idFactory,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.map(keyType, valueType, nullable: true),
            )
            .toUnFormattedString()
            .should
            .be("person.myProperty");
      });
    });
  });
}
