// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/scope.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_provider.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:analyzer/dart/element/type_visitor.dart';
import 'package:analyzer/src/dart/resolver/scope.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/value_expression/value_expression_factory.dart';
import 'package:test/test.dart';

const mapVariableName = 'map';
const instanceVariableName = 'person';

main() {
// TODO  NumExpressionFactory(),           IntExpressionFactory()
  group('class: $BoolExpressionFactory', () {
    var expressionFactory = BoolExpressionFactory();
    var propertyName = 'adult';
    var propertyType = code.Type('$bool');
    test('canConvert(bool)==true', () {
      expect(expressionFactory.canConvert(TestType.bool()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "$mapVariableName['$propertyName'] as bool");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] as bool?");
    });

    test('createToObjectPropertyValue', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class $NumExpressionFactory()', () {
    var expressionFactory = NumExpressionFactory();
    var propertyName = 'ageInDays';
    var propertyType = code.Type('$double');
    test('canConvert(num)==true', () {
      expect(expressionFactory.canConvert(TestType.num()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "$mapVariableName['$propertyName'] as num");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] as num?");
    });
    test('createToObjectPropertyValue', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class $IntExpressionFactory()', () {
    var expressionFactory = IntExpressionFactory();
    var propertyName = 'ageInDays';
    var propertyType = code.Type('$double');
    test('canConvert(int)==true', () {
      expect(expressionFactory.canConvert(TestType.int()), true);
    });
    test('canConvert(double)==false', () {
      expect(expressionFactory.canConvert(TestType.double()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "$mapVariableName['$propertyName'] as int");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] as int?");
    });
    test('createToObjectPropertyValue', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });

  group('class $DoubleExpressionFactory()', () {
    var expressionFactory = DoubleExpressionFactory();
    var propertyName = 'ageInDays';
    var propertyType = code.Type('$double');
    test('canConvert(double)==true', () {
      expect(expressionFactory.canConvert(TestType.double()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "($mapVariableName['$propertyName'] as num).toDouble()");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "($mapVariableName['$propertyName'] as num?)?.toDouble()");
    });

    test('createToObjectPropertyValue', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });
  group('class: $StringExpressionFactory', () {
    var expressionFactory = StringExpressionFactory();
    var propertyName = 'name';
    var propertyType = code.Type('$String');
    test('canConvert(String)==true', () {
      expect(expressionFactory.canConvert(TestType.string()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "$mapVariableName['$propertyName'] as String");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] as String?");
    });

    test('createToObjectPropertyValue', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName");
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName");
    });
  });
  group('class: $UriExpressionFactory()', () {
    var expressionFactory = UriExpressionFactory();
    var propertyName = 'webSite';
    var propertyType = code.Type('$Uri');
    test('canConvert(Uri)==true', () {
      expect(expressionFactory.canConvert(TestType.uri()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "Uri.parse($mapVariableName['$propertyName'] as String)");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] == null ? null : Uri.parse($mapVariableName['$propertyName'] as String)");
    });

    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.toString()");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.toString()");
    });
  });

  group('class: $BigIntExpressionFactory()', () {
    var expressionFactory = BigIntExpressionFactory();
    var propertyName = 'ageInMicroSeconds';
    var propertyType = code.Type('$BigInt');
    test('canConvert(Uri)==true', () {
      expect(expressionFactory.canConvert(TestType.bigInt()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "BigInt.parse($mapVariableName['$propertyName'] as String)");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] == null ? null : BigInt.parse($mapVariableName['$propertyName'] as String)");
    });

    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.toString()");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.toString()");
    });
  });

  group("class: $DateTimeExpressionFactory()", () {
    var expressionFactory = DateTimeExpressionFactory();
    var propertyName = 'dateOfBirth';
    var propertyType = code.Type('$DateTime');
    test('canConvert(DateTime)==true', () {
      expect(expressionFactory.canConvert(TestType.dateTime()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "DateTime.parse($mapVariableName['$propertyName'] as String)");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] == null ? null : DateTime.parse($mapVariableName['$propertyName'] as String)");
    });

    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.toIso8601String()");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.toIso8601String()");
    });
  });

  group("class: $DurationExpressionFactory()", () {
    var expressionFactory = DurationExpressionFactory();
    var propertyName = 'age';
    var propertyType = code.Type('$Duration');
    test('canConvert(Duration)==true', () {
      expect(expressionFactory.canConvert(TestType.duration()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "Duration(microseconds: $mapVariableName['$propertyName'] as int)");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] == null ? null : Duration(microseconds: $mapVariableName['$propertyName'] as int)");
    });

    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          "$instanceVariableName.$propertyName.inMicroseconds");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          "$instanceVariableName.$propertyName?.inMicroseconds");
    });
  });

  group("class: $EnumExpressionFactory()", () {
    var expressionFactory = EnumExpressionFactory();
    var propertyName = 'children';
    var propertyType = code.Type('$TestEnum');
    test('canConvert(TestEnum)==true', () {
      expect(expressionFactory.canConvert(TestType.genderEnum()), true);
    });
    test('canConvert(int)==false', () {
      expect(expressionFactory.canConvert(TestType.int()), false);
    });
    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: false)),
          "TestEnum.values.firstWhere((enumValue) "
          "=> enumValue.name==$mapVariableName['$propertyName'])");
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter().unFormatted(
              expressionFactory.createToObjectPropertyValueCode(
                  mapVariableName, propertyName, propertyType,
                  nullable: true)),
          "$mapVariableName['$propertyName'] == null "
          "? null "
          ": TestEnum.values.firstWhere((enumValue) "
          "=> enumValue.name==$mapVariableName['$propertyName'])");
    });

    test('createToObjectPropertyValue nullable=false', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: false,
          )),
          '$instanceVariableName.$propertyName!.name');
    });
    test('createToObjectPropertyValue nullable=true', () {
      expect(
          code.CodeFormatter()
              .unFormatted(expressionFactory.createToMapValueCode(
            instanceVariableName,
            propertyName,
            nullable: true,
          )),
          '$instanceVariableName.$propertyName?.name');
    });
  });
}

class TestType implements InterfaceType {
  final String typeAsString;
  final bool dartCore;

  TestType.bool()
      : typeAsString = "bool",
        dartCore = true;

  TestType.num()
      : typeAsString = "num",
        dartCore = true;

  TestType.int()
      : typeAsString = "int",
        dartCore = true;

  TestType.double()
      : typeAsString = "double",
        dartCore = true;

  TestType.string()
      : typeAsString = "String",
        dartCore = true;

  TestType.uri()
      : typeAsString = "Uri",
        dartCore = true;

  TestType.bigInt()
      : typeAsString = "BigInt",
        dartCore = true;

  TestType.genderEnum()
      : typeAsString = "Gender",
        dartCore = false;

  TestType.dateTime()
      : typeAsString = "DateTime",
        dartCore = true;

  TestType.duration()
      : typeAsString = "Duration",
        dartCore = true;

  @override
  R accept<R>(TypeVisitor<R> visitor) {
    throw UnimplementedError();
  }

  @override
  R acceptWithArgument<R, A>(
      TypeVisitorWithArgument<R, A> visitor, A argument) {
    throw UnimplementedError();
  }

  @override
  List<PropertyAccessorElement> get accessors => throw UnimplementedError();

  @override
  InstantiatedTypeAliasElement? get alias => throw UnimplementedError();

  @override
  List<InterfaceType> get allSupertypes => throw UnimplementedError();

  @override
  InterfaceType? asInstanceOf(InterfaceElement element) {
    throw UnimplementedError();
  }

  @override
  List<ConstructorElement> get constructors => throw UnimplementedError();

  @override
  String get displayName => throw UnimplementedError();

  @override
  ClassElement get element => throw UnimplementedError();

  @override
  InterfaceElement get element2 => TestInterfaceElement(typeAsString);

  @override
  String getDisplayString({required bool withNullability}) =>
      "$typeAsString${withNullability ? '?' : ''}";

  @override
  PropertyAccessorElement? getGetter(String name) {
    throw UnimplementedError();
  }

  @override
  MethodElement? getMethod(String name) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? getSetter(String name) {
    throw UnimplementedError();
  }

  @override
  List<InterfaceType> get interfaces => throw UnimplementedError();

  @override
  bool get isBottom => throw UnimplementedError();

  @override
  bool get isDartAsyncFuture => throw UnimplementedError();

  @override
  bool get isDartAsyncFutureOr => throw UnimplementedError();

  @override
  bool get isDartAsyncStream => throw UnimplementedError();

  @override
  bool get isDartCoreBool => typeAsString == 'bool';

  @override
  bool get isDartCoreDouble => typeAsString == 'double';

  @override
  bool get isDartCoreEnum => typeAsString == 'Gender';

  @override
  bool get isDartCoreFunction => throw UnimplementedError();

  @override
  bool get isDartCoreInt => typeAsString == 'int';

  @override
  bool get isDartCoreIterable => throw UnimplementedError();

  @override
  bool get isDartCoreList => throw UnimplementedError();

  @override
  bool get isDartCoreMap => throw UnimplementedError();

  @override
  bool get isDartCoreNull => throw UnimplementedError();

  @override
  bool get isDartCoreNum => typeAsString == 'num';

  @override
  bool get isDartCoreObject => throw UnimplementedError();

  @override
  bool get isDartCoreSet => throw UnimplementedError();

  @override
  bool get isDartCoreString => typeAsString == 'String';

  @override
  bool get isDartCoreSymbol => throw UnimplementedError();

  @override
  bool get isDynamic => throw UnimplementedError();

  @override
  bool get isVoid => throw UnimplementedError();

  @override
  ConstructorElement? lookUpConstructor(String? name, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpGetter2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpSetter2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  List<MethodElement> get methods => throw UnimplementedError();

  @override
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  String? get name => throw UnimplementedError();

  @override
  NullabilitySuffix get nullabilitySuffix => throw UnimplementedError();

  @override
  DartType resolveToBound(DartType objectType) {
    throw UnimplementedError();
  }

  @override
  InterfaceType? get superclass => throw UnimplementedError();

  @override
  List<InterfaceType> get superclassConstraints => throw UnimplementedError();

  @override
  List<DartType> get typeArguments => throw UnimplementedError();
}

class TestInterfaceElement implements InterfaceElement {
  final String typeAsString;

  TestInterfaceElement(this.typeAsString);

  @override
  T? accept<T>(ElementVisitor<T> visitor) {
    throw UnimplementedError();
  }

  @override
  List<PropertyAccessorElement> get accessors => throw UnimplementedError();

  @override
  List<InterfaceType> get allSupertypes => throw UnimplementedError();

  @override
  List<ConstructorElement> get constructors => throw UnimplementedError();

  @override
  AnalysisContext get context => throw UnimplementedError();

  @override
  Element get declaration => throw UnimplementedError();

  @override
  String get displayName => throw UnimplementedError();

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement2 => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement3 => throw UnimplementedError();

  @override
  List<FieldElement> get fields => throw UnimplementedError();

  @override
  String getDisplayString(
      {required bool withNullability, bool multiline = false}) {
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName(String? shortName) {
    throw UnimplementedError();
  }

  @override
  FieldElement? getField(String name) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? getGetter(String name) {
    throw UnimplementedError();
  }

  @override
  MethodElement? getMethod(String name) {
    throw UnimplementedError();
  }

  @override
  ConstructorElement? getNamedConstructor(String name) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? getSetter(String name) {
    throw UnimplementedError();
  }

  @override
  bool get hasAlwaysThrows => throw UnimplementedError();

  @override
  bool get hasDeprecated => throw UnimplementedError();

  @override
  bool get hasDoNotStore => throw UnimplementedError();

  @override
  bool get hasFactory => throw UnimplementedError();

  @override
  bool get hasInternal => throw UnimplementedError();

  @override
  bool get hasIsTest => throw UnimplementedError();

  @override
  bool get hasIsTestGroup => throw UnimplementedError();

  @override
  bool get hasJS => throw UnimplementedError();

  @override
  bool get hasLiteral => throw UnimplementedError();

  @override
  bool get hasMustBeOverridden => throw UnimplementedError();

  @override
  bool get hasMustCallSuper => throw UnimplementedError();

  @override
  bool get hasNonVirtual => throw UnimplementedError();

  @override
  bool get hasOptionalTypeArgs => throw UnimplementedError();

  @override
  bool get hasOverride => throw UnimplementedError();

  @override
  bool get hasProtected => throw UnimplementedError();

  @override
  bool get hasRequired => throw UnimplementedError();

  @override
  bool get hasSealed => throw UnimplementedError();

  @override
  bool get hasUseResult => throw UnimplementedError();

  @override
  bool get hasVisibleForOverriding => throw UnimplementedError();

  @override
  bool get hasVisibleForTemplate => throw UnimplementedError();

  @override
  bool get hasVisibleForTesting => throw UnimplementedError();

  @override
  int get id => throw UnimplementedError();

  @override
  InterfaceType instantiate(
      {required List<DartType> typeArguments,
      required NullabilitySuffix nullabilitySuffix}) {
    throw UnimplementedError();
  }

  @override
  List<InterfaceType> get interfaces => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => throw UnimplementedError();

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  bool get isSynthetic => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => TestLibraryElement(typeAsString);

  @override
  Source get librarySource => throw UnimplementedError();

  @override
  ElementLocation? get location => throw UnimplementedError();

  @override
  MethodElement? lookUpConcreteMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpGetter(
      String getterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod(String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpSetter(
      String setterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  List<ElementAnnotation> get metadata => throw UnimplementedError();

  @override
  List<MethodElement> get methods => throw UnimplementedError();

  @override
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  int get nameLength => throw UnimplementedError();

  @override
  int get nameOffset => throw UnimplementedError();

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  AnalysisSession? get session => throw UnimplementedError();

  @override
  Source get source => throw UnimplementedError();

  @override
  InterfaceType? get supertype => throw UnimplementedError();

  @override
  E? thisOrAncestorMatching<E extends Element>(
      bool Function(Element p1) predicate) {
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    throw UnimplementedError();
  }

  @override
  InterfaceType get thisType => throw UnimplementedError();

  @override
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  ConstructorElement? get unnamedConstructor => throw UnimplementedError();

  @override
  void visitChildren(ElementVisitor visitor) {}

  @override
  String toString() =>
      typeAsString == 'Gender' ? 'enum Gender' : 'class $typeAsString';
}

class TestLibraryElement implements LibraryElement {
  final String typeAsString;

  TestLibraryElement(this.typeAsString);

  @override
  T? accept<T>(ElementVisitor<T> visitor) {
    throw UnimplementedError();
  }

  @override
  List<ExtensionElement> get accessibleExtensions => throw UnimplementedError();

  @override
  List<AugmentationImportElement> get augmentationImports =>
      throw UnimplementedError();

  @override
  AnalysisContext get context => throw UnimplementedError();

  @override
  Element get declaration => throw UnimplementedError();

  @override
  CompilationUnitElement get definingCompilationUnit =>
      throw UnimplementedError();

  @override
  String get displayName => throw UnimplementedError();

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  Element? get enclosingElement => throw UnimplementedError();

  @override
  Element? get enclosingElement2 => throw UnimplementedError();

  @override
  Element? get enclosingElement3 => throw UnimplementedError();

  @override
  FunctionElement? get entryPoint => throw UnimplementedError();

  @override
  Namespace get exportNamespace => throw UnimplementedError();

  @override
  List<LibraryElement> get exportedLibraries => throw UnimplementedError();

  @override
  List<ExportElement> get exports => throw UnimplementedError();

  @override
  FeatureSet get featureSet => throw UnimplementedError();

  @override
  ClassElement? getClass(String name) {
    throw UnimplementedError();
  }

  @override
  String getDisplayString(
      {required bool withNullability, bool multiline = false}) {
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName(String? shortName) {
    throw UnimplementedError();
  }

  @override
  List<ImportElement> getImportsWithPrefix(PrefixElement prefix) {
    throw UnimplementedError();
  }

  @override
  ClassElement? getType(String className) {
    throw UnimplementedError();
  }

  @override
  bool get hasAlwaysThrows => throw UnimplementedError();

  @override
  bool get hasDeprecated => throw UnimplementedError();

  @override
  bool get hasDoNotStore => throw UnimplementedError();

  @override
  bool get hasFactory => throw UnimplementedError();

  @override
  bool get hasInternal => throw UnimplementedError();

  @override
  bool get hasIsTest => throw UnimplementedError();

  @override
  bool get hasIsTestGroup => throw UnimplementedError();

  @override
  bool get hasJS => throw UnimplementedError();

  @override
  bool get hasLiteral => throw UnimplementedError();

  @override
  bool get hasMustBeOverridden => throw UnimplementedError();

  @override
  bool get hasMustCallSuper => throw UnimplementedError();

  @override
  bool get hasNonVirtual => throw UnimplementedError();

  @override
  bool get hasOptionalTypeArgs => throw UnimplementedError();

  @override
  bool get hasOverride => throw UnimplementedError();

  @override
  bool get hasProtected => throw UnimplementedError();

  @override
  bool get hasRequired => throw UnimplementedError();

  @override
  bool get hasSealed => throw UnimplementedError();

  @override
  bool get hasUseResult => throw UnimplementedError();

  @override
  bool get hasVisibleForOverriding => throw UnimplementedError();

  @override
  bool get hasVisibleForTemplate => throw UnimplementedError();

  @override
  bool get hasVisibleForTesting => throw UnimplementedError();

  @override
  int get id => throw UnimplementedError();

  @override
  String get identifier => throw UnimplementedError();

  @override
  List<LibraryElement> get importedLibraries => throw UnimplementedError();

  @override
  List<ImportElement> get imports => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isBrowserApplication => throw UnimplementedError();

  @override
  bool get isDartAsync => throw UnimplementedError();

  @override
  bool get isDartCore => throw UnimplementedError();

  @override
  bool get isInSdk => throw UnimplementedError();

  @override
  bool get isNonNullableByDefault => throw UnimplementedError();

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => throw UnimplementedError();

  @override
  bool get isSynthetic => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryLanguageVersion get languageVersion => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  List<LibraryExportElement> get libraryExports => throw UnimplementedError();

  @override
  List<LibraryImportElement> get libraryImports => throw UnimplementedError();

  @override
  Source get librarySource => throw UnimplementedError();

  @override
  FunctionElement get loadLibraryFunction => throw UnimplementedError();

  @override
  ElementLocation? get location => throw UnimplementedError();

  @override
  List<ElementAnnotation> get metadata => throw UnimplementedError();

  @override
  String get name => "dart.core";

  @override
  int get nameLength => throw UnimplementedError();

  @override
  int get nameOffset => throw UnimplementedError();

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  List<CompilationUnitElement> get parts => throw UnimplementedError();

  @override
  List<PartElement> get parts2 => throw UnimplementedError();

  @override
  List<PrefixElement> get prefixes => throw UnimplementedError();

  @override
  Namespace get publicNamespace => throw UnimplementedError();

  @override
  Scope get scope => throw UnimplementedError();

  @override
  AnalysisSession get session => throw UnimplementedError();

  @override
  Source get source => throw UnimplementedError();

  @override
  E? thisOrAncestorMatching<E extends Element>(
      bool Function(Element p1) predicate) {
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    throw UnimplementedError();
  }

  @override
  T toLegacyElementIfOptOut<T extends Element>(T element) {
    throw UnimplementedError();
  }

  @override
  DartType toLegacyTypeIfOptOut(DartType type) {
    throw UnimplementedError();
  }

  @override
  Iterable<Element> get topLevelElements => throw UnimplementedError();

  @override
  TypeProvider get typeProvider => throw UnimplementedError();

  @override
  TypeSystem get typeSystem => throw UnimplementedError();

  @override
  List<CompilationUnitElement> get units => throw UnimplementedError();

  @override
  void visitChildren(ElementVisitor visitor) {}
}

enum TestEnum { one, two, tree }
