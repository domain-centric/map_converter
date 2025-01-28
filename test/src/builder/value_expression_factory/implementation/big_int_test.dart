import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/big_int.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  var personClassElement = PersonElementFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';


  group('class: $BigIntExpressionFactory()', () {
    var expressionFactory = BigIntExpressionFactory();
    var propertyName = 'ageInMicroSeconds';
    var type = TypeFake.bigInt();
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      classElement: personClassElement,
      fieldElement: FieldElementFake(propertyName, type),
    );
    test('canConvert(Uri)==true', () {
      expect(
          expressionFactory.canConvert(
            null,
            TypeFake.personClass().element,
            type,
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
            type,
            nullable: false,
          )),
          "BigInt.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] == null ? null : BigInt.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.toString()");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
             objectPropertyExpression(instanceVariableName, propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.toString()");
    });
  });
}
