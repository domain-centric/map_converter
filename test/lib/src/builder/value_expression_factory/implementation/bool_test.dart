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
    test('supports(bool)', () {
      expressionFactory
          .supports(
            TypeFake.bool(),
          )
          .should
          .beOfType<Supported>();
    });
    test('supports(bool?)', () {
      expressionFactory
          .supports(
            TypeFake.bool(nullable: true),
          )
          .should
          .beOfType<Supported>();
    });
    test('supports(int)==false', () {
      expressionFactory
          .supports(
            TypeFake.int(),
          )
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject nullable=false', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bool(),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as bool ");
    });
    test('mapValueToObject nullable=true', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bool(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] as bool? ");
    });

    test('objectToMapValue nullable=false', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName as bool ");
    });
    test('objectToMapValue nullable=true', () {
      expressionFactory
          .objectToMapValueFunction(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName");
    });
  });
}
