import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/enum.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $EnumExpressionFactory()", () {
    var expressionFactory = EnumExpressionFactory();
    var propertyName = 'gender';
    var propertyWithBuildInfo = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.genderEnum()),
    );
    test('supports(TestEnum) should return Supported', () {
      expressionFactory
          .supports(TypeFake.genderEnum(), null)
          .should
          .beOfType<Supported>();
    });
    test('supports(TestEnum?) should return Supported', () {
      expressionFactory
          .supports(TypeFake.genderEnum(nullable: true), null)
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
            TypeFake.genderEnum(),
          ))
          .should
          .be("i1.Gender.values.firstWhere((enumValue) "
              "=> enumValue.name==$mapVariableName['$propertyName'])");
    });
    test('mapValueToObject nullable=true', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyWithBuildInfo,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.genderEnum(nullable: true),
          ))
          .should
          .be("$mapVariableName['$propertyName'] == null "
              "? null "
              ": i1.Gender.values.firstWhere((enumValue) "
              "=> enumValue.name==$mapVariableName['$propertyName'])");
    });

    test('objectToMapValue nullable=false', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.genderEnum(),
          ))
          .should
          .be('$instanceVariableName.$propertyName.name');
    });
    test('objectToMapValue nullable=true', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyWithBuildInfo,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.genderEnum(nullable: true),
          ))
          .should
          .be('$instanceVariableName.$propertyName?.name');
    });
  });
}
