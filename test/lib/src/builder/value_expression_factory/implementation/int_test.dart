import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/int.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class $IntExpressionFactory()', () {
    var expressionFactory = IntExpressionFactory();
    var propertyName = 'ageInDays';
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.int()),
    );
    test('supports(int) should return Supported', () {
      expressionFactory
          .supports(TypeFake.int(), null)
          .should
          .beOfType<Supported>();
    });
    test('supports(int?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.int(nullable: true), null)
          .should
          .beOfType<Supported>();
    });
    test('supports(double) should return NotSupported', () {
      expressionFactory
          .supports(TypeFake.double(), null)
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject nullable=false', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.int()))
          .should
          .be("($mapVariableName['$propertyName'] as num ).toInt()");
    });
    test('mapValueToObject nullable=true', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.int(nullable: true)))
          .should
          .be("($mapVariableName['$propertyName'] as num? )?.toInt()");
    });
    test('objectToMapValue nullable=false', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.int()))
          .should
          .be("$instanceVariableName.$propertyName");
    });
    test('objectToMapValue nullable=true', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.int(nullable: true)))
          .should
          .be("$instanceVariableName.$propertyName");
    });
  });
}
