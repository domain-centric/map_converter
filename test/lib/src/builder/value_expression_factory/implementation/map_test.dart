import 'package:map_converter/src/builder/map_converter_builder.dart';
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
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement: FieldElementFake(
              mapVariableName, TypeFake.map(keyType, valueType)));
      test(
          'supports(Map<int,String>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.map(keyType, valueType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Map<int,String>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.map(keyType, valueType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(int) should return NotSupported', () {
        expressionFactory
            .supports(TypeFake.int(), null)
            .should
            .beOfType<NotSupported>();
      });
      test('mapValueToObject nullable=false', () {
        expressionFactory
            .mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.map(keyType, valueType),
            )
            .toUnFormattedString()
            .should
            .be("(myMap['myProperty'] as Map ).map((k,v)=>MapEntry((k as num ).toInt(),v as String ))");
      });
      test('mapValueToObject nullable=true', () {
        expressionFactory
            .mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.map(keyType, valueType, nullable: true),
            )
            .toUnFormattedString()
            .should
            .be("(myMap['myProperty'] as Map? )?.map((k,v)=>MapEntry((k as num ).toInt(),v as String ))");
      });
      test('objectToMapValue nullable=false', () {
        expressionFactory
            .objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.map(keyType, valueType),
            )
            .toUnFormattedString()
            .should
            .be("person.myProperty");
      });
      test('objectToMapValue nullable=true', () {
        expressionFactory
            .objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
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
