import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/duration.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $DurationExpressionFactory()", () {
    var expressionFactory = DurationExpressionFactory();
    var propertyName = 'age';
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.duration()),
    );
    test('supports(Duration) should return Supported', () {
      expressionFactory
          .supports(TypeFake.duration(), null)
          .should
          .beOfType<Supported>();
    });
    test('supports(Duration?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.duration(nullable: true), null)
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
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.duration()))
          .should
          .be("Duration(microseconds: $mapVariableName['$propertyName'] as int )");
    });
    test('mapValueToObject nullable=true', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.duration(nullable: true)))
          .should
          .be("$mapVariableName['$propertyName'] == null ? null : Duration(microseconds: $mapVariableName['$propertyName'] as int )");
    });

    test('objectToMapValue nullable=false', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.duration()))
          .should
          .be("$instanceVariableName.$propertyName.inMicroseconds");
    });
    test('objectToMapValue nullable=true', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.duration(nullable: true)))
          .should
          .be("$instanceVariableName.$propertyName?.inMicroseconds");
    });
  });
}
