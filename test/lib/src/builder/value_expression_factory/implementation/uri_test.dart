import 'package:map_converter/src/builder/value_expression_factory/implementation/uri.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class: $UriExpressionFactory()', () {
    var expressionFactory = UriExpressionFactory();
    var propertyName = 'webSite';
    test('supports(Uri) should return Supported', () {
      expressionFactory.supports(TypeFake.uri()).should.beOfType<Supported>();
    });
    test('supports(Uri?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.uri(nullable: true))
          .should
          .beOfType<Supported>();
    });
    test('supports(int) should return NotSupported', () {
      expressionFactory
          .supports(TypeFake.int())
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject nullable=false', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.uri(),
          )
          .toUnFormattedString()
          .should
          .be("Uri.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject nullable=true', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.uri(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] == null ? null : Uri.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue nullable=false', () {
      expressionFactory
          .objectToMapValueFunction(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.uri(),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName.toString()");
    });
    test('objectToMapValue nullable=true', () {
      expressionFactory
          .objectToMapValueFunction(
              idFactory,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.uri(nullable: true))
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName?.toString()");
    });
  });
}
