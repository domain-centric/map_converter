import 'package:map_converter/src/builder/value_expression_factory/implementation/big_int.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class: $BigIntExpressionFactory()', () {
    var expressionFactory = BigIntExpressionFactory();
    var propertyName = 'ageInMicroSeconds';
    // var propertyWithBuildInfo = PropertyWithBuildInfo(
    //   propertyName,
    //   element: elementFake(propertyName, TypeFake.bigInt()),
    // );
    test('supports(BigInt)', () {
      expressionFactory
          .supports(TypeFake.bigInt())
          .should
          .beOfType<Supported>();
    });
    test('supports(BigInt?)', () {
      expressionFactory
          .supports(TypeFake.bigInt(nullable: true))
          .should
          .beOfType<Supported>();
    });
    test('supports(int)', () {
      expressionFactory
          .supports(
            TypeFake.int(),
          )
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject(BigInt)', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bigInt(),
          )
          .toUnFormattedString()
          .should
          .be("BigInt.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject(BigInt?)', () {
      expressionFactory
          .mapValueToObjectFunction(
            idFactory,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bigInt(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$mapVariableName['$propertyName'] == null ? null : BigInt.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue(BigInt)', () {
      expressionFactory
          .objectToMapValueFunction(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bigInt(),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName.toString()");
    });
    test('objectToMapValue(BigInt?)', () {
      expressionFactory
          .objectToMapValueFunction(
            idFactory,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bigInt(nullable: true),
          )
          .toUnFormattedString()
          .should
          .be("$instanceVariableName.$propertyName?.toString()");
    });
  });
}
