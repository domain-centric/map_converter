import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/big_int.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class: $BigIntExpressionFactory()', () {
    var expressionFactory = BigIntExpressionFactory();
    var propertyName = 'ageInMicroSeconds';
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.bigInt()),
    );
    test('supports(BigInt)', () {
      expressionFactory
          .supports(TypeFake.bigInt(), null)
          .should
          .beOfType<Supported>();
    });
    test('supports(BigInt?)', () {
      expressionFactory
          .supports(TypeFake.bigInt(nullable: true), null)
          .should
          .beOfType<Supported>();
    });
    test('supports(int)', () {
      expressionFactory
          .supports(
            TypeFake.int(),
            null,
          )
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject(BigInt)', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bigInt(),
          ))
          .should
          .be("BigInt.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject(BigInt?)', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.bigInt(nullable: true),
          ))
          .should
          .be("$mapVariableName['$propertyName'] == null ? null : BigInt.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue(BigInt)', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bigInt(),
          ))
          .should
          .be("$instanceVariableName.$propertyName.toString()");
    });
    test('objectToMapValue(BigInt?)', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bigInt(nullable: true),
          ))
          .should
          .be("$instanceVariableName.$propertyName?.toString()");
    });
  });
}
