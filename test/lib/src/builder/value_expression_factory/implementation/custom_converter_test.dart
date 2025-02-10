import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/custom_converter.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group('class: $CustomConverterExpressionFactory', () {
    var expressionFactory = CustomConverterExpressionFactory();
    var propertyName = 'adult';

    var propertyAnnotationWithoutConverter = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.personClass()),
    );
    var propertyAnnotationWithConverter = PropertyWithBuildInfo(
      propertyName,
      fieldElement: FieldElementFake(propertyName, TypeFake.personClass()),
      converterType: DartTypeFake(TypeFake.customConverter()),
    );

    test('supports(Person ,null) should return NotSupported', () {
      expressionFactory
          .supports(
            TypeFake.personClass(),
            null,
          )
          .should
          .beOfType<NotSupported>();
    });

    test(
        'supports(Person, propertyAnnotationWithConverter) should return Supported',
        () {
      expressionFactory
          .supports(
            TypeFake.personClass(),
            propertyAnnotationWithConverter,
          )
          .should
          .beOfType<Supported>();
    });

    test(
        'supports(Person?, propertyAnnotationWithConverter) should return Supported',
        () {
      expressionFactory
          .supports(
            TypeFake.personClass(nullable: true),
            propertyAnnotationWithConverter,
          )
          .should
          .beOfType<Supported>();
    });

    test(
        'supports(Person, propertyAnnotationWithoutConverter) should return NotSupported',
        () {
      expressionFactory
          .supports(
            TypeFake.personClass(),
            propertyAnnotationWithoutConverter,
          )
          .should
          .beOfType<NotSupported>();
    });

    test(
        'supports(int, propertyAnnotationWithoutConverter)  should return NotSupported',
        () {
      expressionFactory
          .supports(TypeFake.int(), propertyAnnotationWithoutConverter)
          .should
          .beOfType<NotSupported>();
    });
    test('mapValueToObject nullable=false', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyAnnotationWithConverter,
            mapValueExpression(mapVariableName, propertyName),
            TypeFake.personClass(),
          ))
          .should
          .be("i1.MyCustomConverter().fromPrimitive(map['adult'])");
    });
    test('mapValueToObject nullable=true', () {
      var personType = TypeFake.personClass(nullable: true);
      code.CodeFormatter()
          .unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyAnnotationWithConverter,
            mapValueExpression(mapVariableName, propertyName),
            personType,
          ))
          .should
          .be("i1.MyCustomConverter()?.fromPrimitive(map['adult'])");
    });

    test('objectToMapValue nullable=false', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyAnnotationWithConverter,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(),
          ))
          .should
          .be("i1.MyCustomConverter().toPrimitive(person.adult)");
    });
    test('objectToMapValue nullable=true', () {
      code.CodeFormatter()
          .unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyAnnotationWithConverter,
            objectPropertyExpression(instanceVariableName, propertyName),
            TypeFake.bool(),
          ))
          .should
          .be("i1.MyCustomConverter().toPrimitive(person.adult)");
    });
  });
}
