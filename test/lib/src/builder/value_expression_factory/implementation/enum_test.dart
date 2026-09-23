import 'package:map_converter/src/builder/value_expression_factory/implementation/enum.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $EnumExpressionFactory()", () {
    var expressionFactory = EnumExpressionFactory();
    var propertyName = 'gender';
    test('supports(TestEnum) should return Supported', () {
      expressionFactory
          .supports(TypeFake.genderEnum())
          .should
          .beOfType<Supported>();
    });
    test('supports(TestEnum?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.genderEnum(nullable: true))
          .should
          .beOfType<Supported>();
    });
    test('supports(int) should return NotSupported', () {
      expressionFactory
          .supports(TypeFake.int())
          .should
          .beOfType<NotSupported>();
    });
    test('.fromMapValue nullable=false', () {
      expressionFactory
          .fromMapValue(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.genderEnum(),
          )
          .toUnFormattedString()
          .should
          .be("i1.Gender.values.firstWhere((enumValue) "
              "=> enumValue.name==$mapVariableName['$propertyName'])");
    });
    test('.fromMapValue nullable=true', () {
      expressionFactory
          .fromMapValue(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.genderEnum(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] == null "
              "? null "
              ": i1.Gender.values.firstWhere((enumValue) "
              "=> enumValue.name==$mapVariableName['$propertyName'])");
    });

    test('toMapValue nullable=false', () {
      expressionFactory
          .toMapValue(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.genderEnum(),
          )
          .toUnFormattedString()
          .should
          .be('$instanceVariableName.$propertyName.name');
    });
    test('toMapValue nullable=true', () {
      expressionFactory
          .toMapValue(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.genderEnum(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be('$instanceVariableName.$propertyName?.name');
    });
  });
}
