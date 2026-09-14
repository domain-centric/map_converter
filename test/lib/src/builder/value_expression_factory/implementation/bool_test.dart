import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/bool.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class: $BoolExpressionFactory', () {
    var expressionFactory = BoolExpressionFactory();
    var propertyName = 'adult';
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.bool()),
    );
    test('supports(bool)', () {
      expressionFactory
          .supports(
            TypeFake.bool(),
            null,
          )
          .should
          .beOfType<Supported>();
    });
    test('supports(bool?)', () {
      expressionFactory
          .supports(
            TypeFake.bool(nullable: true),
            null,
          )
          .should
          .beOfType<Supported>();
    });
    test('supports(int)==false', () {
      expressionFactory
          .supports(
            TypeFake.int(),
            null,
          )
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject nullable=false', () {
      expressionFactory
          .mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bool(),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as bool ");
    });
    test('mapValueToObject nullable=true', () {
      expressionFactory
          .mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bool(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as bool? ");
    });

    test('objectToMapValue nullable=false', () {
      expressionFactory
          .mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName as bool ");
    });
    test('objectToMapValue nullable=true', () {
      expressionFactory
          .objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName");
    });
  });
}
