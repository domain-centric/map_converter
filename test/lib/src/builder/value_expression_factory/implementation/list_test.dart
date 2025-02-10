import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/list.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:recase/recase.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../value_expression_factory_fake.dart';
import '../value_expression_factory_test.dart';

main() {
  var idFactory = MapConverterLibraryAssetIdFactoryFake();
  const mapVariableName = 'map';
  const instanceVariableName = 'person';

  group("class: $ListExpressionFactory()", () {
    var expressionFactory = ListExpressionFactory();

    group("for: List<bool>", () {
      var genericType = TypeFake.bool();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test('supports(List<bool>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<bool>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
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
              TypeFake.list(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList().cast<i1.bool>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['bools']?.map((listElement) => listElement as bool ).toList().cast<i1.bool>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: List<num>", () {
      var genericType = TypeFake.num();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test('supports(List<num>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<num>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
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
              TypeFake.list(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList().cast<i1.num>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['nums']?.map((listElement) => listElement as num ).toList().cast<i1.num>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: List<int>", () {
      var genericType = TypeFake.int();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test('supports(List<int>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<int>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<int>) should return NotSupported', () {
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
              TypeFake.list(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((listElement) => (listElement as num ).toInt()).toList().cast<i1.int>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['ints']?.map((listElement) => (listElement as num ).toInt()).toList().cast<i1.int>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: List<double>", () {
      var genericType = TypeFake.double();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement: FieldElementFake(
            propertyName,
            TypeFake.list(genericType),
          ));
      test(
          'supports(List<double>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(List<double>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<double>) should return NotSupported', () {
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
              TypeFake.list(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((listElement) => (listElement as num ).toDouble()).toList().cast<i1.double>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['doubles']?.map((listElement) => (listElement as num ).toDouble()).toList().cast<i1.double>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: List<String>", () {
      var genericType = TypeFake.string();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test(
          'supports(List<String>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(List<String>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<String>) should return NotSupported', () {
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
              TypeFake.list(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((listElement) => listElement as $genericType ).toList().cast<i1.String>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['strings']?.map((listElement) => listElement as String ).toList().cast<i1.String>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: List<Uri>", () {
      var genericType = TypeFake.uri();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test('supports(List<Uri>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<Uri>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<Uri>) should return NotSupported', () {
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
              TypeFake.list(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((listElement) => Uri.parse(listElement as String )).toList().cast<i1.Uri>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['uris']?.map((listElement) => Uri.parse(listElement as String )).toList().cast<i1.Uri>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Uri listElement) => listElement.toString()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("person.uris?.map((i1.Uri listElement) => listElement.toString()).toList()");
      });
    });

    group("for: List<BigInt>", () {
      var genericType = TypeFake.bigInt();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test(
          'supports(List<BigInt>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(List<BigInt>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<BigInt>) should return NotSupported', () {
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
              TypeFake.list(genericType),
            ))
            .should
            .be("map['bigInts'].map((listElement) => BigInt.parse(listElement as String )).toList().cast<i1.BigInt>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['bigInts']?.map((listElement) => BigInt.parse(listElement as String )).toList().cast<i1.BigInt>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.BigInt listElement) => listElement.toString()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("person.bigInts?.map((i1.BigInt listElement) => listElement.toString()).toList()");
      });
    });

    group("for: List<DateTime>", () {
      var genericType = TypeFake.dateTime();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test(
          'supports(List<DateTime>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(List<DateTime>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(List<DateTime>) should return Supported', () {
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
              TypeFake.list(genericType),
            ))
            .should
            .be("map['dateTimes'].map((listElement) => DateTime.parse(listElement as String )).toList().cast<i1.DateTime>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['dateTimes']?.map((listElement) => DateTime.parse(listElement as String )).toList().cast<i1.DateTime>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.DateTime listElement) => listElement.toIso8601String()).toList()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("person.dateTimes?.map((i1.DateTime listElement) => listElement.toIso8601String()).toList()");
      });
    });

    group("for: List<Duration>", () {
      var genericType = TypeFake.duration();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test(
          'supports(List<Duration>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(List<Duration>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
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
              TypeFake.list(genericType),
            ))
            .should
            .be("map['durations'].map((listElement) => Duration(microseconds: listElement as int )).toList().cast<i1.Duration>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['durations']?.map((listElement) => Duration(microseconds: listElement as int )).toList().cast<i1.Duration>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Duration listElement) => listElement.inMicroseconds).toList()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("person.durations?.map((i1.Duration listElement) => listElement.inMicroseconds).toList()");
      });
    });

    group("for: List<GenderEnum>", () {
      var genericType = TypeFake.genderEnum();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test(
          'supports(List<GenderEnum>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(List<GenderEnum>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(int) should return NotSupported', () {
        expressionFactory
            .supports(TypeFake.int(nullable: true), null)
            .should
            .beOfType<NotSupported>();
      });
      test('mapValueToObject nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("map['genders'].map((listElement) => i1.Gender.values.firstWhere((enumValue) => enumValue.name==listElement)).toList().cast<i1.Gender>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['genders']?.map((listElement) => i1.Gender.values.firstWhere((enumValue) => enumValue.name==listElement)).toList().cast<i1.Gender>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Gender listElement) => listElement.name).toList()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("person.genders?.map((i1.Gender listElement) => listElement.name).toList()");
      });
    });

    group("for: List<Person>", () {
      var genericType = TypeFake.personClass();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.list(genericType)));
      test(
          'supports(List<Person>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(List<Person>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.list(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
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
              TypeFake.list(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((listElement) => i1.mapToPerson(listElement as Map<String,dynamic> )).toList().cast<i2.Person>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("map['persons']?.map((listElement) => i1.mapToPerson(listElement as Map<String,dynamic> )).toList().cast<i2.Person>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Person listElement) => i2.personToMap(listElement)).toList()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.list(genericType, nullable: true),
            ))
            .should
            .be("person.persons?.map((i1.Person listElement) => i2.personToMap(listElement)).toList()");
      });
    });
  });
}
