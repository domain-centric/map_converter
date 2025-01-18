import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/value_expression/value_expression_factory.dart';
import 'package:recase/recase.dart';
import 'package:test/test.dart';

import 'value_expression_factory_fake.dart';

const mapVariableName = 'map';
const instanceVariableName = 'person';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  var personClassElement = PersonElementFake();

  group('class: $BoolExpressionFactory', () {
    var expressionFactory = BoolExpressionFactory();
    var propertyName = 'adult';
    var propertyType = TypeFake.bool();
    test('canConvert(bool)==true', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, propertyType),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            propertyType,
            nullable: false,
          )),
          "$mapVariableName['$propertyName'] as bool ");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            propertyType,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] as bool? ");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            TypeFake.bool(),
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            TypeFake.bool(),
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class $NumExpressionFactory()', () {
    var expressionFactory = NumExpressionFactory();
    var propertyName = 'ageInDays';
    var type = TypeFake.num();
    test('canConvert(num)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "$mapVariableName['$propertyName'] as num ");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] as num? ");
    });
    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class $IntExpressionFactory()', () {
    var expressionFactory = IntExpressionFactory();
    var propertyName = 'ageInDays';
    var type = TypeFake.int();
    test('canConvert(int)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(double)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.double()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "$mapVariableName['$propertyName'] as int ");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] as int? ");
    });
    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class $DoubleExpressionFactory()', () {
    var expressionFactory = DoubleExpressionFactory();
    var propertyName = 'ageInDays';
    var type = TypeFake.double();
    test('canConvert(double)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "($mapVariableName['$propertyName'] as num ).toDouble()");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "($mapVariableName['$propertyName'] as num? )?.toDouble()");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class: $StringExpressionFactory', () {
    var expressionFactory = StringExpressionFactory();
    var propertyName = 'name';
    var type = TypeFake.string();
    test('canConvert(String)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "$mapVariableName['$propertyName'] as String ");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] as String? ");
    });
    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class: $UriExpressionFactory()', () {
    var expressionFactory = UriExpressionFactory();
    var propertyName = 'webSite';
    var type = TypeFake.uri();
    test('canConvert(Uri)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "Uri.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] == null ? null : Uri.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.toString()");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.toString()");
    });
  });

  group('class: $BigIntExpressionFactory()', () {
    var expressionFactory = BigIntExpressionFactory();
    var propertyName = 'ageInMicroSeconds';
    var type = TypeFake.bigInt();
    test('canConvert(Uri)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "BigInt.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] == null ? null : BigInt.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.toString()");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.toString()");
    });
  });

  group("class: $DateTimeExpressionFactory()", () {
    var expressionFactory = DateTimeExpressionFactory();
    var propertyName = 'dateOfBirth';
    var type = TypeFake.dateTime();
    test('canConvert(DateTime)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "DateTime.parse($mapVariableName['$propertyName'] as String )");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] == null ? null : DateTime.parse($mapVariableName['$propertyName'] as String )");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.toIso8601String()");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.toIso8601String()");
    });
  });

  group("class: $DurationExpressionFactory()", () {
    var expressionFactory = DurationExpressionFactory();
    var propertyName = 'age';
    var type = TypeFake.duration();
    test('canConvert(Duration)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "Duration(microseconds: $mapVariableName['$propertyName'] as int )");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] == null ? null : Duration(microseconds: $mapVariableName['$propertyName'] as int )");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.inMicroseconds");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.inMicroseconds");
    });
  });

  group("class: $EnumExpressionFactory()", () {
    var expressionFactory = EnumExpressionFactory();
    var propertyName = 'gender';
    var type = TypeFake.genderEnum();
    test('canConvert(TestEnum)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "i1.Gender.values.firstWhere((enumValue) "
          "=> enumValue.name==$mapVariableName['$propertyName'])");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] == null "
          "? null "
          ": i1.Gender.values.firstWhere((enumValue) "
          "=> enumValue.name==$mapVariableName['$propertyName'])");
    });

    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          '$instanceVariableName.$propertyName.name');
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          '$instanceVariableName.$propertyName?.name');
    });
  });

  group("class: $DomainObjectExpressionFactory()", () {
    var expressionFactory = DomainObjectExpressionFactory();
    var propertyName = 'parent';
    var type = TypeFake.personClass();
    test('canConvert(Person,Person)==true', () {
      expect(expressionFactory.canConvert(TypeFake.personClass().element, type),
          true);
    });
    test('canConvert(int)==false', () {
      expect(
          expressionFactory.canConvert(
              TypeFake.personClass().element, TypeFake.int()),
          false);
    });
    test('mapValueToObject nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: false,
          )),
          "i1.mapToPerson($mapVariableName['$propertyName'] as Map<String,dynamic> )");
    });
    test('mapValueToObject nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
            idFactory,
            personClassElement,
            mapValueExpression(propertyName),
            type,
            nullable: true,
          )),
          "$mapVariableName['$propertyName'] == null "
          "? null "
          ": i1.mapToPerson($mapVariableName['$propertyName'] as Map<String,dynamic> )");
    });
    test('objectToMapValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: false,
          )),
          "i1.personToMap($instanceVariableName.$propertyName)");
    });
    test('objectToMapValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
            idFactory,
            personClassElement,
            objectPropertyExpression(propertyName),
            type,
            nullable: true,
          )),
          "$instanceVariableName.parent == null ? null : "
          "i1.${instanceVariableName}ToMap"
          "($instanceVariableName.$propertyName!)");
    });
  });

  group("class: $ListExpressionFactory()", () {
    var expressionFactory = ListExpressionFactory();

    group("for: List<bool>", () {
      var genericType = TypeFake.bool();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyType = TypeFake.list(genericType);
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => (listElement as num ).toDouble()).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => (listElement as num? )?.toDouble()).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement as $genericType? ).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => Uri.parse(listElement as String )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : Uri.parse(listElement as String )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Uri listElement) => listElement.toString()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => BigInt.parse(listElement as String )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : BigInt.parse(listElement as String )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.BigInt listElement) => listElement.toString()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => DateTime.parse(listElement as String )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : DateTime.parse(listElement as String )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.DateTime listElement) => listElement.toIso8601String()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => Duration(microseconds: listElement as int )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : Duration(microseconds: listElement as int )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Duration listElement) => listElement.inMicroseconds).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => i1.Gender.values.firstWhere((enumValue) => enumValue.name==listElement)).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : i1.Gender.values.firstWhere((enumValue) => enumValue.name==listElement)).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Gender listElement) => listElement.name).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
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
      test('canConvert(Person,$propertyType>)==true', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, propertyType),
            true);
      });
      test('canConvert(Person, int)==false', () {
        expect(
            expressionFactory.canConvert(
                TypeFake.personClass().element, TypeFake.int()),
            false);
      });
      test('mapValueToObject nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$mapVariableName['$propertyName'].map((listElement) => i1.mapToPerson(listElement as Map<String,dynamic> )).toList()");
      });
      test('mapValueToObject nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              personClassElement,
              mapValueExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$mapVariableName['$propertyName']?.map((listElement) => listElement == null ? null : i1.mapToPerson(listElement as Map<String,dynamic> )).toList()");
      });
      test('objectToMapValue nullable=false', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: false,
            )),
            "$instanceVariableName.$propertyName.map((i1.Person listElement) => i2.personToMap(listElement)).toList()");
      });
      test('objectToMapValue nullable=true', () {
        expect(
            code.CodeFormatter().unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              personClassElement,
              objectPropertyExpression(propertyName),
              propertyType,
              nullable: true,
            )),
            "$instanceVariableName.$propertyName?.map((i1.Person? listElement) => listElement == null ? null : i2.personToMap(listElement)).toList()");
      });
    });
  });
}

objectPropertyExpression(String propertyName) =>
    code.Expression.ofVariable(instanceVariableName).getProperty(propertyName);

mapValueExpression(String propertyName) =>
    code.Expression.ofVariable(mapVariableName)
        .index(code.Expression.ofString(propertyName));
