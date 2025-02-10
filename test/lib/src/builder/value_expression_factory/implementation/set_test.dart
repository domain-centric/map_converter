import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/Set.dart';
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

  group("class: $SetExpressionFactory()", () {
    var expressionFactory = SetExpressionFactory();

    group("for: Set<bool>", () {
      var genericType = TypeFake.bool();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test('supports(Set<bool>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<bool>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
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
              TypeFake.set(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((setElement) => setElement as $genericType ).toSet().cast<i1.bool>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['bools']?.map((setElement) => setElement as bool ).toSet().cast<i1.bool>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
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
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: Set<num>", () {
      var genericType = TypeFake.num();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test('supports(Set<num>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<num>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
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
              TypeFake.set(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((setElement) => setElement as $genericType ).toSet().cast<i1.num>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['nums']?.map((setElement) => setElement as num ).toSet().cast<i1.num>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
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
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: Set<int>", () {
      var genericType = TypeFake.int();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test('supports(Set<int>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<int>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<int>) should return NotSupported', () {
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
              TypeFake.set(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((setElement) => (setElement as num ).toInt()).toSet().cast<i1.int>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['ints']?.map((setElement) => (setElement as num ).toInt()).toSet().cast<i1.int>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
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
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: Set<double>", () {
      var genericType = TypeFake.double();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement: FieldElementFake(
            propertyName,
            TypeFake.set(genericType),
          ));
      test('supports(Set<double>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Set<double>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<double>) should return NotSupported', () {
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
              TypeFake.set(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((setElement) => (setElement as num ).toDouble()).toSet().cast<i1.double>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['doubles']?.map((setElement) => (setElement as num ).toDouble()).toSet().cast<i1.double>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
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
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: Set<String>", () {
      var genericType = TypeFake.string();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test('supports(Set<String>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Set<String>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<String>) should return NotSupported', () {
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
              TypeFake.set(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((setElement) => setElement as $genericType ).toSet().cast<i1.String>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['strings']?.map((setElement) => setElement as String ).toSet().cast<i1.String>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
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
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("$instanceVariableName.$propertyName");
      });
    });

    group("for: Set<Uri>", () {
      var genericType = TypeFake.uri();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test('supports(Set<Uri>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<Uri>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<Uri>) should return NotSupported', () {
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
              TypeFake.set(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((setElement) => Uri.parse(setElement as String )).toSet().cast<i1.Uri>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['uris']?.map((setElement) => Uri.parse(setElement as String )).toSet().cast<i1.Uri>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Uri setElement) => setElement.toString()).toSet()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("person.uris?.map((i1.Uri setElement) => setElement.toString()).toSet()");
      });
    });

    group("for: Set<BigInt>", () {
      var genericType = TypeFake.bigInt();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test('supports(Set<BigInt>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Set<BigInt>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<BigInt>) should return NotSupported', () {
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
              TypeFake.set(genericType),
            ))
            .should
            .be("map['bigInts'].map((setElement) => BigInt.parse(setElement as String )).toSet().cast<i1.BigInt>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['bigInts']?.map((setElement) => BigInt.parse(setElement as String )).toSet().cast<i1.BigInt>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.BigInt setElement) => setElement.toString()).toSet()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("person.bigInts?.map((i1.BigInt setElement) => setElement.toString()).toSet()");
      });
    });

    group("for: Set<DateTime>", () {
      var genericType = TypeFake.dateTime();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test(
          'supports(Set<DateTime>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Set<DateTime>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test('supports(Set<DateTime>) should return Supported', () {
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
              TypeFake.set(genericType),
            ))
            .should
            .be("map['dateTimes'].map((setElement) => DateTime.parse(setElement as String )).toSet().cast<i1.DateTime>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['dateTimes']?.map((setElement) => DateTime.parse(setElement as String )).toSet().cast<i1.DateTime>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.DateTime setElement) => setElement.toIso8601String()).toSet()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("person.dateTimes?.map((i1.DateTime setElement) => setElement.toIso8601String()).toSet()");
      });
    });

    group("for: Set<Duration>", () {
      var genericType = TypeFake.duration();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test(
          'supports(Set<Duration>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Set<Duration>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
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
              TypeFake.set(genericType),
            ))
            .should
            .be("map['durations'].map((setElement) => Duration(microseconds: setElement as int )).toSet().cast<i1.Duration>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['durations']?.map((setElement) => Duration(microseconds: setElement as int )).toSet().cast<i1.Duration>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Duration setElement) => setElement.inMicroseconds).toSet()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("person.durations?.map((i1.Duration setElement) => setElement.inMicroseconds).toSet()");
      });
    });

    group("for: Set<GenderEnum>", () {
      var genericType = TypeFake.genderEnum();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test(
          'supports(Set<GenderEnum>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Set<GenderEnum>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
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
              TypeFake.set(genericType),
            ))
            .should
            .be("map['genders'].map((setElement) => i1.Gender.values.firstWhere((enumValue) => enumValue.name==setElement)).toSet().cast<i1.Gender>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['genders']?.map((setElement) => i1.Gender.values.firstWhere((enumValue) => enumValue.name==setElement)).toSet().cast<i1.Gender>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Gender setElement) => setElement.name).toSet()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("person.genders?.map((i1.Gender setElement) => setElement.name).toSet()");
      });
    });

    group("for: Set<Person>", () {
      var genericType = TypeFake.personClass();
      var propertyName = '${genericType.toString().camelCase}s';
      var propertyWithBuildInfo = PropertyWithBuildInfo(propertyName,
          fieldElement:
              FieldElementFake(propertyName, TypeFake.set(genericType)));
      test('supports(Set<Person>) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType), null)
            .should
            .beOfType<SupportedIfQueriesAreSupported>();
      });
      test(
          'supports(Set<Person>?) should return SupportedIfQueriesAreSupported',
          () {
        expressionFactory
            .supports(TypeFake.set(genericType, nullable: true), null)
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
              TypeFake.set(genericType),
            ))
            .should
            .be("$mapVariableName['$propertyName'].map((setElement) => i1.mapToPerson(setElement as Map<String,dynamic> )).toSet().cast<i2.Person>()");
      });
      test('mapValueToObject nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.mapValueToObject(
              idFactory,
              propertyWithBuildInfo,
              mapValueExpression(mapVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("map['persons']?.map((setElement) => i1.mapToPerson(setElement as Map<String,dynamic> )).toSet().cast<i2.Person>()");
      });
      test('objectToMapValue nullable=false', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType),
            ))
            .should
            .be("$instanceVariableName.$propertyName.map((i1.Person setElement) => i2.personToMap(setElement)).toSet()");
      });
      test('objectToMapValue nullable=true', () {
        code.CodeFormatter()
            .unFormatted(expressionFactory.objectToMapValue(
              idFactory,
              propertyWithBuildInfo,
              objectPropertyExpression(instanceVariableName, propertyName),
              TypeFake.set(genericType, nullable: true),
            ))
            .should
            .be("person.persons?.map((i1.Person setElement) => i2.personToMap(setElement)).toSet()");
      });
    });
  });
}
