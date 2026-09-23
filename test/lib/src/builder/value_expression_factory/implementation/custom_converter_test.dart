import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

void main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';
  const propertyName = 'adult';
  const functionName = 'customConverterFunction';

  group('function createFromMapValueExpressionCustomFunction', () {
    test('fromMapValuenullable=false', () {
      createFromMapValueExpressionCustomFunction(
          functionName: functionName, functionLibraryUri: '')(
        idFactory,
        mapValueExpression(mapVariableName, propertyName),
        TypeFake.personClass(),
      ).toUnFormattedString().should.be("i1.$functionName(map['adult'])");
    });
    test('fromMapValuenullable=true', () {
      var personType = TypeFake.personClass(nullable: true);
      createFromMapValueExpressionCustomFunction(
          functionName: functionName, functionLibraryUri: '')(
        idFactory,
        mapValueExpression(mapVariableName, propertyName),
        personType,
      ).toUnFormattedString().should.be("i1.$functionName(map['adult'])");
    });
  });

  group('function createToMapValueExpressionCustomFunction', () {
    test('toMapValue nullable=false', () {
      createToMapValueExpressionCustomFunction(
          functionName: functionName, functionLibraryUri: '')(
        idFactory,
        objectPropertyExpression(instanceVariableName, propertyName),
        TypeFake.bool(),
      ).toUnFormattedString().should.be("i1.$functionName(person.adult)");
    });
    test('toMapValue nullable=true', () {
      createToMapValueExpressionCustomFunction(
          functionName: functionName, functionLibraryUri: '')(
        idFactory,
        objectPropertyExpression(instanceVariableName, propertyName),
        TypeFake.bool(),
      ).toUnFormattedString().should.be("i1.$functionName(person.adult)");
    });
  });
}
