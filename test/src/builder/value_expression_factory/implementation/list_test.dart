import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/list.dart';
import 'package:recase/recase.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  var personClassElement = PersonElementFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $ListExpressionFactory()", () {
    var expressionFactory = ListExpressionFactory();

    group("for: List<bool>", () {
      var genericType = TypeFake.bool();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName");
      });
    });

    group("for: List<num>", () {
      var genericType = TypeFake.num();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName");
      });
    });

    group("for: List<int>", () {
      var genericType = TypeFake.int();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName");
      });
    });

    group("for: List<double>", () {
      var genericType = TypeFake.double();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => (listElement as num ).toDouble()).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => (listElement as num? )?.toDouble()).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName");
      });
    });

    group("for: List<String>", () {
      var genericType = TypeFake.string();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName");
      });
    });

    group("for: List<Uri>", () {
      var genericType = TypeFake.uri();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => Uri.parse(listElement as String )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : Uri.parse(listElement as String )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Uri listElement) => listElement.toString()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName?.map((i1.Uri? listElement) => listElement?.toString()).toList()");
      });
    });

    group("for: List<BigInt>", () {
      var genericType = TypeFake.bigInt();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => BigInt.parse(listElement as String )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : BigInt.parse(listElement as String )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.BigInt listElement) => listElement.toString()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName?.map((i1.BigInt? listElement) => listElement?.toString()).toList()");
      });
    });

    group("for: List<DateTime>", () {
      var genericType = TypeFake.dateTime();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => DateTime.parse(listElement as String )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : DateTime.parse(listElement as String )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.DateTime listElement) => listElement.toIso8601String()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName?.map((i1.DateTime? listElement) => listElement?.toIso8601String()).toList()");
      });
    });

    group("for: List<Duration>", () {
      var genericType = TypeFake.duration();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => Duration(microseconds: listElement as int )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : Duration(microseconds: listElement as int )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Duration listElement) => listElement.inMicroseconds).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName?.map((i1.Duration? listElement) => listElement?.inMicroseconds).toList()");
      });
    });

    group("for: List<GenderEnum>", () {
      var genericType = TypeFake.genderEnum();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => i1.Gender.values.firstWhere((enumValue) => enumValue.name==listElement)).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : i1.Gender.values.firstWhere((enumValue) => enumValue.name==listElement)).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Gender listElement) => listElement.name).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName?.map((i1.Gender? listElement) => listElement?.name).toList()");
      });
    });

    group("for: List<Person>", () {
      var genericType = TypeFake.personClass();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      var propertyWithBuildInfo = PropertyWithBuildInfo(
        propertyName,
        classElement: personClassElement,
        fieldElement: FieldElementFake(propertyName, propertyType),
      );
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
              null,
              TypeFake.personClass().element,
              propertyType,
            ),
            true);
      });
      test('canConvert(Person, int)==false', () {
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
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => i1.mapToPerson(listElement as Map<String,dynamic> )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : i1.mapToPerson(listElement as Map<String,dynamic> )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Person listElement) => i2.personToMap(listElement)).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName?.map((i1.Person? listElement) => listElement == null ? null : i2.personToMap(listElement)).toList()");
      });
    });
  });
}
