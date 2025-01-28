import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/annotation.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/custom_converter.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import 'value_expression_factory_impl_test.dart';

const mapVariableName = 'map';
const instanceVariableName = 'person';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  var personClassElement = PersonElementFake();

  group('class: $CustomConverterExpressionFactory', () {
    var expressionFactory = CustomConverterExpressionFactory();
    var propertyName = 'adult';
    var propertyType = TypeFake.bool();
    var propertyAnnotationWithoutConverter = PropertyWithBuildInfo(
      propertyName,
      classElement: personClassElement,
      fieldElement: FieldElementFake(propertyName, propertyType),
    );
    var propertyAnnotationWithConverter = PropertyWithBuildInfo(
      propertyName,
      classElement: personClassElement,
      fieldElement: FieldElementFake(propertyName, propertyType),
      converterType: DartTypeFake(TypeFake.customConverter()),
    );

    test('canConvert(null, Person ,bool)==false', () {
      expect(
          expressionFactory.canConvert(
            null,
            TypeFake.personClass().element,
            propertyType,
          ),
          false);
    });

    test('canConvert(propertyAnnotationWithoutConverter, Person ,bool)==false',
        () {
      expect(
          expressionFactory.canConvert(
            propertyAnnotationWithoutConverter,
            TypeFake.personClass().element,
            propertyType,
          ),
          false);
    });

    test('canConvert(propertyAnnotationWithConverter, Person ,bool)==true', () {
      expect(
          expressionFactory.canConvert(
            propertyAnnotationWithConverter,
            TypeFake.personClass().element,
            propertyType,
          ),
          true);
    });

    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
            null,
            TypeFake.personClass().element,
            TypeFake.int(),
          ),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyAnnotationWithConverter,
            mapValueExpression(propertyName),
            propertyType,
            nullable: false,
          )),
          "i1.MyCustomConverter().fromPrimitive(map['adult'])");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            propertyAnnotationWithConverter,
            mapValueExpression(propertyName),
            propertyType,
            nullable: true,
          )),
          "i1.MyCustomConverter().fromPrimitive(map['adult'])");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyAnnotationWithConverter,
            objectPropertyExpression(propertyName),
            TypeFake.bool(),
            nullable: false,
          )),
          "i1.MyCustomConverter().toPrimitive(person.adult)");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            propertyAnnotationWithConverter,
            objectPropertyExpression(propertyName),
            TypeFake.bool(),
            nullable: true,
          )),
          "i1.MyCustomConverter().toPrimitive(person.adult)");
    });
  });
}
