import 'package:map_converter/src/builder/value_expression_factory/implementation/domain_object.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $DomainObjectExpressionFactory()", () {
    var expressionFactory = DomainObjectExpressionFactory();
    var propertyName = 'parent';
    test('supports(Person) should return Supported', () {
      expressionFactory
          .supports(TypeFake.personClass())
          .should
          .beOfType<Supported>();
    });

    test('supports(Person?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.personClass(nullable: true))
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
            TypeFake.personClass(),
          )
          .toUnFormattedString()
          .should
          .be("i1.mapToPerson($mapVariableName['$propertyName'] as Map<String,dynamic> )");
    });
    test('fromMapValue, nullable=true', () {
      expressionFactory
          .fromMapValue(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.personClass(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] == null "
              "? null "
              ": i1.mapToPerson($mapVariableName['$propertyName'] as Map<String,dynamic> )");
    });
    test('toMapValue nullable=false', () {
      expressionFactory
          .toMapValue(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.personClass(),
          )
          .toUnFormattedString()
          .should
          .be("i1.personToMap($instanceVariableName.$propertyName)");
    });
    test('toMapValue nullable=true', () {
      expressionFactory
          .toMapValue(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.personClass(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.parent == null ? null : "
              "i1.${instanceVariableName}ToMap"
              "($instanceVariableName.$propertyName!)");
    });
  });
}
