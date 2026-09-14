import 'package:map_converter/src/builder/map_converter_builder.dart';
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
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.personClass()),
    );
    test('supports(Person) should return Supported', () {
      expressionFactory
          .supports(TypeFake.personClass(), null)
          .should
          .beOfType<Supported>();
    });

    test('supports(Person?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.personClass(nullable: true), null)
          .should
          .beOfType<Supported>();
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
            TypeFake.personClass(),
          )
          .toUnFormattedString()
          .should
          .be("i1.mapToPerson($mapVariableName['$propertyName'] as Map<String,dynamic> )");
    });
    test('mapValueToObject nullable=true', () {
      expressionFactory
          .mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.personClass(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] == null "
              "? null "
              ": i1.mapToPerson($mapVariableName['$propertyName'] as Map<String,dynamic> )");
    });
    test('objectToMapValue nullable=false', () {
      expressionFactory
          .objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.personClass(),
          )
          .toUnFormattedString()
          .should
          .be("i1.personToMap($instanceVariableName.$propertyName)");
    });
    test('objectToMapValue nullable=true', () {
      expressionFactory
          .objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
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
