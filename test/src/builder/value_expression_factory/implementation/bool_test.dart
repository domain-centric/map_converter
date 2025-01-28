import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/bool.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  var personClassElement = PersonElementFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class: $BoolExpressionFactory', () {
    var expressionFactory = BoolExpressionFactory();
    var propertyName = 'adult';
    var propertyType = TypeFake.bool();
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      classElement: personClassElement,
      fieldElement: FieldElementFake(propertyName, propertyType),
    );
    test('canConvert(bool)==true', () {
      expect(
          expressionFactory.canConvert(
            null,
            TypeFake.personClass().element,
            propertyType,
          ),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
            null,
            TypeFake.personClass().element,
            TypeFake.int(),
          ),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            propertyType,
            nullable: false,
          )),
          "$mapVariableName['$propertyName'] as bool ");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            propertyType,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] as bool? ");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(),
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
             objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(),
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });
}
