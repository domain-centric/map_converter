import 'package:dart_code/dart_code.dart';
import 'package:map_converter/src/builder/value_expression/value_expression_factory.dart';
import 'package:test/test.dart';

const mapVariableName = 'map';
const personVariableName = 'person';

main() {
  group('$BasicTypeExpressionFactory(String)', () {
    var expressionFactory = BasicTypeExpressionFactory(String);
    var propertyName = 'name';
    test('canConvert(String)==true', () {
      expect(expressionFactory.canConvert(String), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(int), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
                  nullable: false)),
          "$mapVariableName['$propertyName'] as String");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
                  nullable: true)),
          "$mapVariableName['$propertyName'] as String?");
    });

    test('createToObjectPropertyValue', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: false,
          )),
          "$personVariableName.$propertyName");
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: true,
          )),
          "$personVariableName.$propertyName");
    });
  });

  group('$BasicTypeExpressionFactory(bool)', () {
    var expressionFactory = BasicTypeExpressionFactory(bool);
    var propertyName = 'adult';
    test('canConvert(bool)==true', () {
      expect(expressionFactory.canConvert(bool), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(int), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
                  nullable: false)),
          "$mapVariableName['$propertyName'] as bool");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
                  nullable: true)),
          "$mapVariableName['$propertyName'] as bool?");
    });

    test('createToObjectPropertyValue', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: false,
          )),
          "$personVariableName.$propertyName");
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: true,
          )),
          "$personVariableName.$propertyName");
    });
  });
  group('$DoubleExpressionFactory()', () {
    var expressionFactory = DoubleExpressionFactory();
    var propertyName = 'ageInDays';
    test('canConvert(double)==true', () {
      expect(expressionFactory.canConvert(double), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(int), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
                  nullable: false)),
          "($mapVariableName['$propertyName'] as num).toDouble()");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
                  nullable: true)),
          "($mapVariableName['$propertyName'] as num?)?.toDouble()");
    });

    test('createToObjectPropertyValue', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: false,
          )),
          "$personVariableName.$propertyName");
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: true,
          )),
          "$personVariableName.$propertyName");
    });
  });



  group('$ParsableTypeExpressionFactory(Uri)', () {
    var expressionFactory = ParsableTypeExpressionFactory(Uri);
    var propertyName = 'webSite';
    test('canConvert(Uri)==true', () {
      expect(expressionFactory.canConvert(Uri), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(int), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
              nullable: false)),
          "Uri.parse($mapVariableName['$propertyName'] as String)");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
              nullable: true)),
          "$mapVariableName['$propertyName'] == null ? null : Uri.parse($mapVariableName['$propertyName'] as String)");
    });

    test('createToObjectPropertyValue nullable=false', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: false,
          )),
          "$personVariableName.$propertyName.toString()");

    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: true,
          )),
          "$personVariableName.$propertyName?.toString()");

    });
  });

  group('$ParsableTypeExpressionFactory(BigInt)', () {
    var expressionFactory = ParsableTypeExpressionFactory(BigInt);
    var propertyName = 'ageInMicroSeconds';
    test('canConvert(Uri)==true', () {
      expect(expressionFactory.canConvert(BigInt), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(int), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
              nullable: false)),
          "BigInt.parse($mapVariableName['$propertyName'] as String)");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory
              .createToObjectPropertyValueCode(mapVariableName, propertyName,
              nullable: true)),
          "$mapVariableName['$propertyName'] == null ? null : BigInt.parse($mapVariableName['$propertyName'] as String)");
    });

    test('createToObjectPropertyValue nullable=false', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: false,
          )),
          "$personVariableName.$propertyName.toString()");

    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          CodeFormatter().unFormatted(expressionFactory.createToMapValueCode(
            personVariableName,
            propertyName,
            nullable: true,
          )),
          "$personVariableName.$propertyName?.toString()");

    });
  });
}
