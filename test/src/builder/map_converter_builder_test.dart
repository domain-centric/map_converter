import 'package:analyzer/dart/element/element.dart';
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import 'value_expression_factory/value_expression_factory_fake.dart';

class _SchemaClassElementFake extends PersonElementFake {
  @override
  String? get documentationComment => 'A person';

  @override
  List<FieldElement> get fields => [
        _SchemaFieldElementFake('name', TypeFake.string()),
        _SchemaFieldElementFake('age', TypeFake.int(nullable: true)),
      ];
}

class _SchemaFieldElementFake extends FieldElementFake {
  _SchemaFieldElementFake(super.name, super.type);

  @override
  String? get documentationComment => 'Field documentation';

  @override
  SetterElement? get setter => null;
}

void main() {
  test('SchemaField should generate the schema map', () {
    final domainClass = DomainClass(
      _SchemaClassElementFake(),
      Constructor.withoutParameters(),
      [
        FieldMetadata(
          _SchemaFieldElementFake('name', TypeFake.string()),
          alias: 'fullName',
          toMapValueExpressionFunction: null,
          fromMapValueExpressionFunction: null,
        ),
        FieldMetadata(
          _SchemaFieldElementFake('age', TypeFake.int(nullable: true)),
          toMapValueExpressionFunction: null,
          fromMapValueExpressionFunction: null,
        ),
      ],
      GenerateOptions.all,
    );

    SchemaField(domainClass, MapConverterLibraryAssetIdFactoryFake())
        .toUnFormattedString()
        .should
        .be("final Map<String,dynamic> schema = const "
            "{'className' : 'Person','classDescription' : "
            "'A person','classLibraryUri' : "
            "'person/person.dart','mapperClassName' : "
            "'PersonMapper','mapperClassLibraryUri' : '"
            "package:map_converter/src/builder/map_converter_builder.dart',"
            "'fields' : [{'name' : 'name','mapKey' : 'fullName',"
            "'description' : 'Field documentation',"
            "'presence' : 'required','type' : 'String?',"
            "'typeLibraryUri' : ''},{'name' : 'age',"
            "'mapKey' : 'age','description' : 'Field documentation',"
            "'presence' : 'optional','type' : 'int?','typeLibraryUri' : ''}]};");
  });
}
