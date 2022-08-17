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
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  R acceptWithArgument<R, A>(
      TypeVisitorWithArgument<R, A> visitor, A argument) {
    // TODO: implement acceptWithArgument
    throw UnimplementedError();
  }

  @override
  // TODO: implement accessors
  List<PropertyAccessorElement> get accessors => throw UnimplementedError();

  @override
  // TODO: implement alias
  InstantiatedTypeAliasElement? get alias => throw UnimplementedError();

  @override
  // TODO: implement allSupertypes
  List<InterfaceType> get allSupertypes => throw UnimplementedError();

  @override
  InterfaceType? asInstanceOf(InterfaceElement element) {
    // TODO: implement asInstanceOf
    throw UnimplementedError();
  }

  @override
  // TODO: implement constructors
  List<ConstructorElement> get constructors => throw UnimplementedError();

  @override
  // TODO: implement displayName
  String get displayName => throw UnimplementedError();

  @override
  // TODO: implement element
  ClassElement get element => throw UnimplementedError();

  @override
  // TODO: implement element2
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
  // TODO: implement interfaces
  List<InterfaceType> get interfaces => throw UnimplementedError();

  @override
  // TODO: implement isBottom
  bool get isBottom => throw UnimplementedError();

  @override
  // TODO: implement isDartAsyncFuture
  bool get isDartAsyncFuture => throw UnimplementedError();

  @override
  // TODO: implement isDartAsyncFutureOr
  bool get isDartAsyncFutureOr => throw UnimplementedError();

  @override
  // TODO: implement isDartAsyncStream
  bool get isDartAsyncStream => throw UnimplementedError();

  @override
  bool get isDartCoreBool => typeAsString == 'bool';

  @override
  bool get isDartCoreDouble => typeAsString == 'double';

  @override
  bool get isDartCoreEnum => typeAsString == 'Gender';

  @override
  // TODO: implement isDartCoreFunction
  bool get isDartCoreFunction => throw UnimplementedError();

  @override
  // TODO: implement isDartCoreInt
  bool get isDartCoreInt => typeAsString == 'int';

  @override
  // TODO: implement isDartCoreIterable
  bool get isDartCoreIterable => throw UnimplementedError();

  @override
  // TODO: implement isDartCoreList
  bool get isDartCoreList => throw UnimplementedError();

  @override
  // TODO: implement isDartCoreMap
  bool get isDartCoreMap => throw UnimplementedError();

  @override
  // TODO: implement isDartCoreNull
  bool get isDartCoreNull => throw UnimplementedError();

  @override
  bool get isDartCoreNum => typeAsString == 'num';

  @override
  // TODO: implement isDartCoreObject
  bool get isDartCoreObject => throw UnimplementedError();

  @override
  // TODO: implement isDartCoreSet
  bool get isDartCoreSet => throw UnimplementedError();

  @override
  // TODO: implement isDartCoreString
  bool get isDartCoreString => typeAsString == 'String';

  @override
  // TODO: implement isDartCoreSymbol
  bool get isDartCoreSymbol => throw UnimplementedError();

  @override
  // TODO: implement isDynamic
  bool get isDynamic => throw UnimplementedError();

  @override
  // TODO: implement isVoid
  bool get isVoid => throw UnimplementedError();

  @override
  ConstructorElement? lookUpConstructor(String? name, LibraryElement library) {
    // TODO: implement lookUpConstructor
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpGetter2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    // TODO: implement lookUpGetter2
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    // TODO: implement lookUpMethod2
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpSetter2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    // TODO: implement lookUpSetter2
    throw UnimplementedError();
  }

  @override
  // TODO: implement methods
  List<MethodElement> get methods => throw UnimplementedError();

  @override
  // TODO: implement mixins
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  // TODO: implement name
  String? get name => throw UnimplementedError();

  @override
  // TODO: implement nullabilitySuffix
  NullabilitySuffix get nullabilitySuffix => throw UnimplementedError();

  @override
  DartType resolveToBound(DartType objectType) {
    // TODO: implement resolveToBound
    throw UnimplementedError();
  }

  @override
  // TODO: implement superclass
  InterfaceType? get superclass => throw UnimplementedError();

  @override
  // TODO: implement superclassConstraints
  List<InterfaceType> get superclassConstraints => throw UnimplementedError();

  @override
  // TODO: implement typeArguments
  List<DartType> get typeArguments => throw UnimplementedError();
}

class TestInterfaceElement implements InterfaceElement {
  final String typeAsString;

  TestInterfaceElement(this.typeAsString);

  @override
  T? accept<T>(ElementVisitor<T> visitor) {
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  // TODO: implement accessors
  List<PropertyAccessorElement> get accessors => throw UnimplementedError();

  @override
  // TODO: implement allSupertypes
  List<InterfaceType> get allSupertypes => throw UnimplementedError();

  @override
  // TODO: implement constructors
  List<ConstructorElement> get constructors => throw UnimplementedError();

  @override
  // TODO: implement context
  AnalysisContext get context => throw UnimplementedError();

  @override
  // TODO: implement declaration
  Element get declaration => throw UnimplementedError();

  @override
  // TODO: implement displayName
  String get displayName => throw UnimplementedError();

  @override
  // TODO: implement documentationComment
  String? get documentationComment => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement
  CompilationUnitElement get enclosingElement => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement2
  CompilationUnitElement get enclosingElement2 => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement3
  CompilationUnitElement get enclosingElement3 => throw UnimplementedError();

  @override
  // TODO: implement fields
  List<FieldElement> get fields => throw UnimplementedError();

  @override
  String getDisplayString(
      {required bool withNullability, bool multiline = false}) {
    // TODO: implement getDisplayString
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName(String? shortName) {
    // TODO: implement getExtendedDisplayName
    throw UnimplementedError();
  }

  @override
  FieldElement? getField(String name) {
    // TODO: implement getField
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? getGetter(String name) {
    // TODO: implement getGetter
    throw UnimplementedError();
  }

  @override
  MethodElement? getMethod(String name) {
    // TODO: implement getMethod
    throw UnimplementedError();
  }

  @override
  ConstructorElement? getNamedConstructor(String name) {
    // TODO: implement getNamedConstructor
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? getSetter(String name) {
    // TODO: implement getSetter
    throw UnimplementedError();
  }

  @override
  // TODO: implement hasAlwaysThrows
  bool get hasAlwaysThrows => throw UnimplementedError();

  @override
  // TODO: implement hasDeprecated
  bool get hasDeprecated => throw UnimplementedError();

  @override
  // TODO: implement hasDoNotStore
  bool get hasDoNotStore => throw UnimplementedError();

  @override
  // TODO: implement hasFactory
  bool get hasFactory => throw UnimplementedError();

  @override
  // TODO: implement hasInternal
  bool get hasInternal => throw UnimplementedError();

  @override
  // TODO: implement hasIsTest
  bool get hasIsTest => throw UnimplementedError();

  @override
  // TODO: implement hasIsTestGroup
  bool get hasIsTestGroup => throw UnimplementedError();

  @override
  // TODO: implement hasJS
  bool get hasJS => throw UnimplementedError();

  @override
  // TODO: implement hasLiteral
  bool get hasLiteral => throw UnimplementedError();

  @override
  // TODO: implement hasMustBeOverridden
  bool get hasMustBeOverridden => throw UnimplementedError();

  @override
  // TODO: implement hasMustCallSuper
  bool get hasMustCallSuper => throw UnimplementedError();

  @override
  // TODO: implement hasNonVirtual
  bool get hasNonVirtual => throw UnimplementedError();

  @override
  // TODO: implement hasOptionalTypeArgs
  bool get hasOptionalTypeArgs => throw UnimplementedError();

  @override
  // TODO: implement hasOverride
  bool get hasOverride => throw UnimplementedError();

  @override
  // TODO: implement hasProtected
  bool get hasProtected => throw UnimplementedError();

  @override
  // TODO: implement hasRequired
  bool get hasRequired => throw UnimplementedError();

  @override
  // TODO: implement hasSealed
  bool get hasSealed => throw UnimplementedError();

  @override
  // TODO: implement hasUseResult
  bool get hasUseResult => throw UnimplementedError();

  @override
  // TODO: implement hasVisibleForOverriding
  bool get hasVisibleForOverriding => throw UnimplementedError();

  @override
  // TODO: implement hasVisibleForTemplate
  bool get hasVisibleForTemplate => throw UnimplementedError();

  @override
  // TODO: implement hasVisibleForTesting
  bool get hasVisibleForTesting => throw UnimplementedError();

  @override
  // TODO: implement id
  int get id => throw UnimplementedError();

  @override
  InterfaceType instantiate(
      {required List<DartType> typeArguments,
      required NullabilitySuffix nullabilitySuffix}) {
    // TODO: implement instantiate
    throw UnimplementedError();
  }

  @override
  // TODO: implement interfaces
  List<InterfaceType> get interfaces => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement? library) {
    // TODO: implement isAccessibleIn
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    // TODO: implement isAccessibleIn2
    throw UnimplementedError();
  }

  @override
  // TODO: implement isPrivate
  bool get isPrivate => throw UnimplementedError();

  @override
  // TODO: implement isPublic
  bool get isPublic => throw UnimplementedError();

  @override
  // TODO: implement isSimplyBounded
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  // TODO: implement isSynthetic
  bool get isSynthetic => throw UnimplementedError();

  @override
  // TODO: implement kind
  ElementKind get kind => throw UnimplementedError();

  @override
  // TODO: implement library
  LibraryElement get library => TestLibraryElement(typeAsString);

  @override
  // TODO: implement librarySource
  Source get librarySource => throw UnimplementedError();

  @override
  // TODO: implement location
  ElementLocation? get location => throw UnimplementedError();

  @override
  MethodElement? lookUpConcreteMethod(
      String methodName, LibraryElement library) {
    // TODO: implement lookUpConcreteMethod
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpGetter(
      String getterName, LibraryElement library) {
    // TODO: implement lookUpGetter
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedMethod(
      String methodName, LibraryElement library) {
    // TODO: implement lookUpInheritedMethod
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod(String methodName, LibraryElement library) {
    // TODO: implement lookUpMethod
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpSetter(
      String setterName, LibraryElement library) {
    // TODO: implement lookUpSetter
    throw UnimplementedError();
  }

  @override
  // TODO: implement metadata
  List<ElementAnnotation> get metadata => throw UnimplementedError();

  @override
  // TODO: implement methods
  List<MethodElement> get methods => throw UnimplementedError();

  @override
  // TODO: implement mixins
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement nameLength
  int get nameLength => throw UnimplementedError();

  @override
  // TODO: implement nameOffset
  int get nameOffset => throw UnimplementedError();

  @override
  // TODO: implement nonSynthetic
  Element get nonSynthetic => throw UnimplementedError();

  @override
  // TODO: implement session
  AnalysisSession? get session => throw UnimplementedError();

  @override
  // TODO: implement source
  Source get source => throw UnimplementedError();

  @override
  // TODO: implement supertype
  InterfaceType? get supertype => throw UnimplementedError();

  @override
  E? thisOrAncestorMatching<E extends Element>(
      bool Function(Element p1) predicate) {
    // TODO: implement thisOrAncestorMatching
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    // TODO: implement thisOrAncestorOfType
    throw UnimplementedError();
  }

  @override
  // TODO: implement thisType
  InterfaceType get thisType => throw UnimplementedError();

  @override
  // TODO: implement typeParameters
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  // TODO: implement unnamedConstructor
  ConstructorElement? get unnamedConstructor => throw UnimplementedError();

  @override
  void visitChildren(ElementVisitor visitor) {
    // TODO: implement visitChildren
  }

  @override
  String toString() =>
      typeAsString == 'Gender' ? 'enum Gender' : 'class $typeAsString';
}

class TestLibraryElement implements LibraryElement {
  final String typeAsString;

  TestLibraryElement(this.typeAsString);

  @override
  T? accept<T>(ElementVisitor<T> visitor) {
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  // TODO: implement accessibleExtensions
  List<ExtensionElement> get accessibleExtensions => throw UnimplementedError();

  @override
  // TODO: implement augmentationImports
  List<AugmentationImportElement> get augmentationImports =>
      throw UnimplementedError();

  @override
  // TODO: implement context
  AnalysisContext get context => throw UnimplementedError();

  @override
  // TODO: implement declaration
  Element get declaration => throw UnimplementedError();

  @override
  // TODO: implement definingCompilationUnit
  CompilationUnitElement get definingCompilationUnit =>
      throw UnimplementedError();

  @override
  // TODO: implement displayName
  String get displayName => throw UnimplementedError();

  @override
  // TODO: implement documentationComment
  String? get documentationComment => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement
  Element? get enclosingElement => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement2
  Element? get enclosingElement2 => throw UnimplementedError();

  @override
  // TODO: implement enclosingElement3
  Element? get enclosingElement3 => throw UnimplementedError();

  @override
  // TODO: implement entryPoint
  FunctionElement? get entryPoint => throw UnimplementedError();

  @override
  // TODO: implement exportNamespace
  Namespace get exportNamespace => throw UnimplementedError();

  @override
  // TODO: implement exportedLibraries
  List<LibraryElement> get exportedLibraries => throw UnimplementedError();

  @override
  // TODO: implement exports
  List<ExportElement> get exports => throw UnimplementedError();

  @override
  // TODO: implement featureSet
  FeatureSet get featureSet => throw UnimplementedError();

  @override
  ClassElement? getClass(String name) {
    // TODO: implement getClass
    throw UnimplementedError();
  }

  @override
  String getDisplayString(
      {required bool withNullability, bool multiline = false}) {
    // TODO: implement getDisplayString
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName(String? shortName) {
    // TODO: implement getExtendedDisplayName
    throw UnimplementedError();
  }

  @override
  List<ImportElement> getImportsWithPrefix(PrefixElement prefix) {
    // TODO: implement getImportsWithPrefix
    throw UnimplementedError();
  }

  @override
  ClassElement? getType(String className) {
    // TODO: implement getType
    throw UnimplementedError();
  }

  @override
  // TODO: implement hasAlwaysThrows
  bool get hasAlwaysThrows => throw UnimplementedError();

  @override
  // TODO: implement hasDeprecated
  bool get hasDeprecated => throw UnimplementedError();

  @override
  // TODO: implement hasDoNotStore
  bool get hasDoNotStore => throw UnimplementedError();

  @override
  // TODO: implement hasFactory
  bool get hasFactory => throw UnimplementedError();

  @override
  // TODO: implement hasInternal
  bool get hasInternal => throw UnimplementedError();

  @override
  // TODO: implement hasIsTest
  bool get hasIsTest => throw UnimplementedError();

  @override
  // TODO: implement hasIsTestGroup
  bool get hasIsTestGroup => throw UnimplementedError();

  @override
  // TODO: implement hasJS
  bool get hasJS => throw UnimplementedError();

  @override
  // TODO: implement hasLiteral
  bool get hasLiteral => throw UnimplementedError();

  @override
  // TODO: implement hasMustBeOverridden
  bool get hasMustBeOverridden => throw UnimplementedError();

  @override
  // TODO: implement hasMustCallSuper
  bool get hasMustCallSuper => throw UnimplementedError();

  @override
  // TODO: implement hasNonVirtual
  bool get hasNonVirtual => throw UnimplementedError();

  @override
  // TODO: implement hasOptionalTypeArgs
  bool get hasOptionalTypeArgs => throw UnimplementedError();

  @override
  // TODO: implement hasOverride
  bool get hasOverride => throw UnimplementedError();

  @override
  // TODO: implement hasProtected
  bool get hasProtected => throw UnimplementedError();

  @override
  // TODO: implement hasRequired
  bool get hasRequired => throw UnimplementedError();

  @override
  // TODO: implement hasSealed
  bool get hasSealed => throw UnimplementedError();

  @override
  // TODO: implement hasUseResult
  bool get hasUseResult => throw UnimplementedError();

  @override
  // TODO: implement hasVisibleForOverriding
  bool get hasVisibleForOverriding => throw UnimplementedError();

  @override
  // TODO: implement hasVisibleForTemplate
  bool get hasVisibleForTemplate => throw UnimplementedError();

  @override
  // TODO: implement hasVisibleForTesting
  bool get hasVisibleForTesting => throw UnimplementedError();

  @override
  // TODO: implement id
  int get id => throw UnimplementedError();

  @override
  // TODO: implement identifier
  String get identifier => throw UnimplementedError();

  @override
  // TODO: implement importedLibraries
  List<LibraryElement> get importedLibraries => throw UnimplementedError();

  @override
  // TODO: implement imports
  List<ImportElement> get imports => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement? library) {
    // TODO: implement isAccessibleIn
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    // TODO: implement isAccessibleIn2
    throw UnimplementedError();
  }

  @override
  // TODO: implement isBrowserApplication
  bool get isBrowserApplication => throw UnimplementedError();

  @override
  // TODO: implement isDartAsync
  bool get isDartAsync => throw UnimplementedError();

  @override
  // TODO: implement isDartCore
  bool get isDartCore => throw UnimplementedError();

  @override
  // TODO: implement isInSdk
  bool get isInSdk => throw UnimplementedError();

  @override
  // TODO: implement isNonNullableByDefault
  bool get isNonNullableByDefault => throw UnimplementedError();

  @override
  // TODO: implement isPrivate
  bool get isPrivate => throw UnimplementedError();

  @override
  // TODO: implement isPublic
  bool get isPublic => throw UnimplementedError();

  @override
  // TODO: implement isSynthetic
  bool get isSynthetic => throw UnimplementedError();

  @override
  // TODO: implement kind
  ElementKind get kind => throw UnimplementedError();

  @override
  // TODO: implement languageVersion
  LibraryLanguageVersion get languageVersion => throw UnimplementedError();

  @override
  // TODO: implement library
  LibraryElement get library => throw UnimplementedError();

  @override
  // TODO: implement libraryExports
  List<LibraryExportElement> get libraryExports => throw UnimplementedError();

  @override
  // TODO: implement libraryImports
  List<LibraryImportElement> get libraryImports => throw UnimplementedError();

  @override
  // TODO: implement librarySource
  Source get librarySource => throw UnimplementedError();

  @override
  // TODO: implement loadLibraryFunction
  FunctionElement get loadLibraryFunction => throw UnimplementedError();

  @override
  // TODO: implement location
  ElementLocation? get location => throw UnimplementedError();

  @override
  // TODO: implement metadata
  List<ElementAnnotation> get metadata => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => "dart.core";

  @override
  // TODO: implement nameLength
  int get nameLength => throw UnimplementedError();

  @override
  // TODO: implement nameOffset
  int get nameOffset => throw UnimplementedError();

  @override
  // TODO: implement nonSynthetic
  Element get nonSynthetic => throw UnimplementedError();

  @override
  // TODO: implement parts
  List<CompilationUnitElement> get parts => throw UnimplementedError();

  @override
  // TODO: implement parts2
  List<PartElement> get parts2 => throw UnimplementedError();

  @override
  // TODO: implement prefixes
  List<PrefixElement> get prefixes => throw UnimplementedError();

  @override
  // TODO: implement publicNamespace
  Namespace get publicNamespace => throw UnimplementedError();

  @override
  // TODO: implement scope
  Scope get scope => throw UnimplementedError();

  @override
  // TODO: implement session
  AnalysisSession get session => throw UnimplementedError();

  @override
  // TODO: implement source
  Source get source => throw UnimplementedError();

  @override
  E? thisOrAncestorMatching<E extends Element>(
      bool Function(Element p1) predicate) {
    // TODO: implement thisOrAncestorMatching
    throw UnimplementedError();
  }

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    // TODO: implement thisOrAncestorOfType
    throw UnimplementedError();
  }

  @override
  T toLegacyElementIfOptOut<T extends Element>(T element) {
    // TODO: implement toLegacyElementIfOptOut
    throw UnimplementedError();
  }

  @override
  DartType toLegacyTypeIfOptOut(DartType type) {
    // TODO: implement toLegacyTypeIfOptOut
    throw UnimplementedError();
  }

  @override
  // TODO: implement topLevelElements
  Iterable<Element> get topLevelElements => throw UnimplementedError();

  @override
  // TODO: implement typeProvider
  TypeProvider get typeProvider => throw UnimplementedError();

  @override
  // TODO: implement typeSystem
  TypeSystem get typeSystem => throw UnimplementedError();

  @override
  // TODO: implement units
  List<CompilationUnitElement> get units => throw UnimplementedError();

  @override
  void visitChildren(ElementVisitor visitor) {
    // TODO: implement visitChildren
  }
}

enum TestEnum { one, two, tree }
