// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/constant/value.dart';
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
import 'package:build/src/asset/id.dart';
import 'package:build/src/builder/builder.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';

const _person = "Person";

class TypeFake implements InterfaceType {
  final String typeAsString;
  final bool dartCore;
  final String libraryUrl;
  @override
  List<DartType> typeArguments = [];

  TypeFake.bool()
      : typeAsString = "bool",
        dartCore = true,
        libraryUrl = '';

  TypeFake.num()
      : typeAsString = "num",
        dartCore = true,
        libraryUrl = '';

  TypeFake.int()
      : typeAsString = "int",
        dartCore = true,
        libraryUrl = '';

  TypeFake.double()
      : typeAsString = "double",
        dartCore = true,
        libraryUrl = '';

  TypeFake.string()
      : typeAsString = "String",
        dartCore = true,
        libraryUrl = '';

  TypeFake.uri()
      : typeAsString = "Uri",
        dartCore = true,
        libraryUrl = '';

  TypeFake.bigInt()
      : typeAsString = "BigInt",
        dartCore = true,
        libraryUrl = '';

  TypeFake.dateTime()
      : typeAsString = "DateTime",
        dartCore = true,
        libraryUrl = '';

  TypeFake.duration()
      : typeAsString = "Duration",
        dartCore = true,
        libraryUrl = '';

  TypeFake.genderEnum()
      : typeAsString = "Gender",
        dartCore = false,
        libraryUrl = 'person/person.dart';

  TypeFake.personClass()
      : typeAsString = _person,
        dartCore = false,
        libraryUrl = 'person/person.dart';

  TypeFake.list(TypeFake genericType)
      : typeAsString = "List",
        dartCore = true,
        libraryUrl = '',
        typeArguments = [genericType];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeFake &&
          runtimeType == other.runtimeType &&
          typeAsString == other.typeAsString &&
          dartCore == other.dartCore &&
          libraryUrl == other.libraryUrl &&
          typeArguments == other.typeArguments;

  @override
  int get hashCode =>
      typeAsString.hashCode ^
      dartCore.hashCode ^
      libraryUrl.hashCode ^
      typeArguments.hashCode;

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
  List<InterfaceType> get allSupertypes => [];

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
  InterfaceElement get element2 {
    if (typeAsString == _person) {
      return PersonElementFake();
    } else {
      return InterfaceElementFake(this);
    }
  }

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
  bool get isDartCoreList => typeAsString == 'List';

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
  bool get isDartCoreRecord => throw UnimplementedError();

  @override
  String toString() {
    String string = typeAsString;
    if (typeArguments.isNotEmpty) {
      string += '<';
      string += typeArguments.map((e) => e.toString()).join(', ');
      string += '>';
    }
    return string;
  }
}

class InterfaceElementFake implements InterfaceElement {
  final TypeFake typeFake;

  InterfaceElementFake(this.typeFake);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterfaceElementFake &&
          runtimeType == other.runtimeType &&
          typeFake == other.typeFake;

  @override
  int get hashCode => typeFake.hashCode;

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
  String get displayName => typeFake.typeAsString;

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
  LibraryElement get library => LibraryElementFake(typeFake);

  @override
  Source get librarySource => SourceFake(typeFake);

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
  String toString() => typeFake.typeAsString == 'Gender'
      ? 'enum Gender'
      : 'class ${typeFake.typeAsString}';

  @override
  PropertyAccessorElement? lookUpInheritedConcreteGetter(
      String getterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedConcreteMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpInheritedConcreteSetter(
      String setterName, LibraryElement library) {
    throw UnimplementedError();
  }
}

class SourceFake implements Source {
  TypeFake typeFake;

  SourceFake(this.typeFake);

  @override
  TimestampedData<String> get contents => throw UnimplementedError();

  @override
  bool exists() {
    throw UnimplementedError();
  }

  @override
  String get fullName => throw UnimplementedError();

  @override
  String get shortName => throw UnimplementedError();

  @override
  Uri get uri => Uri.parse(typeFake.libraryUrl);

  @override
  String toString() => typeFake.libraryUrl;
}

class LibraryElementFake implements LibraryElement {
  final TypeFake typeFake;

  LibraryElementFake(this.typeFake);

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

class MapConverterLibraryAssetIdFactoryFake
    implements MapConverterLibraryAssetIdFactory {
  @override
  Builder get builder => throw UnimplementedError();

  @override
  AssetId createOutputId(AssetId inputId) {
    throw UnimplementedError();
  }

  @override
  String createOutputUriForType(InterfaceType domainObjectType) =>
      'package:map_converter/src/builder/map_converter_builder.dart';
}

class PersonElementFake extends ClassElement {
  @override
  T? accept<T>(ElementVisitor<T> visitor) {
    throw UnimplementedError();
  }

  @override
  List<PropertyAccessorElement> get accessors => throw UnimplementedError();

  @override
  List<InterfaceType> get allSupertypes => [];

  @override
  ClassAugmentationElement? get augmentation => throw UnimplementedError();

  @override
  AugmentedClassElement get augmented => throw UnimplementedError();

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
  List<FieldElement> get fields =>
      [FieldElementFake('name', TypeFake.string())];

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
  bool get hasNonFinalField => throw UnimplementedError();

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
  bool get hasStaticMember => throw UnimplementedError();

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
  bool get isAbstract => false;

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isDartCoreEnum => throw UnimplementedError();

  @override
  bool get isDartCoreObject => throw UnimplementedError();

  @override
  bool get isEnum => throw UnimplementedError();

  @override
  bool get isMixin => throw UnimplementedError();

  @override
  bool get isMixinApplication => throw UnimplementedError();

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => true;

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  bool get isSynthetic => throw UnimplementedError();

  @override
  bool get isValidMixin => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  Source get librarySource => SourceFake(TypeFake.personClass());

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
  PropertyAccessorElement? lookUpInheritedConcreteGetter(
      String getterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedConcreteMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpInheritedConcreteSetter(
      String setterName, LibraryElement library) {
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
  List<InterfaceType> get superclassConstraints => throw UnimplementedError();

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
  InterfaceType get thisType => TypeFake.personClass();

  @override
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  ConstructorElement? get unnamedConstructor => throw UnimplementedError();

  @override
  void visitChildren(ElementVisitor visitor) {}
}

class FieldElementFake extends FieldElement {
  @override
  final String name;
  @override
  final InterfaceType type;

  FieldElementFake(this.name, this.type);

  @override
  T? accept<T>(ElementVisitor<T> visitor) {
    throw UnimplementedError();
  }

  @override
  FieldAugmentationElement? get augmentation => throw UnimplementedError();

  @override
  DartObject? computeConstantValue() {
    throw UnimplementedError();
  }

  @override
  AnalysisContext get context => throw UnimplementedError();

  @override
  FieldElement get declaration => throw UnimplementedError();

  @override
  String get displayName => throw UnimplementedError();

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  Element get enclosingElement => throw UnimplementedError();

  @override
  Element get enclosingElement2 => throw UnimplementedError();

  @override
  Element get enclosingElement3 => throw UnimplementedError();

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
  PropertyAccessorElement? get getter => throw UnimplementedError();

  @override
  bool get hasAlwaysThrows => throw UnimplementedError();

  @override
  bool get hasDeprecated => throw UnimplementedError();

  @override
  bool get hasDoNotStore => throw UnimplementedError();

  @override
  bool get hasFactory => throw UnimplementedError();

  @override
  bool get hasImplicitType => throw UnimplementedError();

  @override
  bool get hasInitializer => throw UnimplementedError();

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
  bool get isAbstract => false;

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isConst => false;

  @override
  bool get isConstantEvaluated => throw UnimplementedError();

  @override
  bool get isCovariant => throw UnimplementedError();

  @override
  bool get isEnumConstant => throw UnimplementedError();

  @override
  bool get isExternal => throw UnimplementedError();

  @override
  bool get isFinal => throw UnimplementedError();

  @override
  bool get isLate => throw UnimplementedError();

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => throw UnimplementedError();

  @override
  bool get isStatic => false;

  @override
  bool get isSynthetic => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  Source? get librarySource => throw UnimplementedError();

  @override
  ElementLocation? get location => throw UnimplementedError();

  @override
  List<ElementAnnotation> get metadata => throw UnimplementedError();

  @override
  int get nameLength => throw UnimplementedError();

  @override
  int get nameOffset => throw UnimplementedError();

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  AnalysisSession? get session => throw UnimplementedError();

  @override
  PropertyAccessorElement? get setter => PropertyAccessorElementFake();

  @override
  Source? get source => throw UnimplementedError();

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
  void visitChildren(ElementVisitor visitor) {}
}

class PropertyAccessorElementFake extends PropertyAccessorElement {
  @override
  T? accept<T>(ElementVisitor<T> visitor) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorAugmentationElement? get augmentation =>
      throw UnimplementedError();

  @override
  AnalysisContext get context => throw UnimplementedError();

  @override
  PropertyAccessorElement? get correspondingGetter =>
      throw UnimplementedError();

  @override
  PropertyAccessorElement? get correspondingSetter =>
      throw UnimplementedError();

  @override
  PropertyAccessorElement get declaration => throw UnimplementedError();

  @override
  String get displayName => throw UnimplementedError();

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  Element get enclosingElement => throw UnimplementedError();

  @override
  Element get enclosingElement2 => throw UnimplementedError();

  @override
  Element get enclosingElement3 => throw UnimplementedError();

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
  bool get hasAlwaysThrows => throw UnimplementedError();

  @override
  bool get hasDeprecated => throw UnimplementedError();

  @override
  bool get hasDoNotStore => throw UnimplementedError();

  @override
  bool get hasFactory => throw UnimplementedError();

  @override
  bool get hasImplicitReturnType => throw UnimplementedError();

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
  bool get isAbstract => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool isAccessibleIn2(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isAsynchronous => throw UnimplementedError();

  @override
  bool get isExternal => throw UnimplementedError();

  @override
  bool get isGenerator => throw UnimplementedError();

  @override
  bool get isGetter => throw UnimplementedError();

  @override
  bool get isOperator => throw UnimplementedError();

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => throw UnimplementedError();

  @override
  bool get isSetter => throw UnimplementedError();

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  bool get isStatic => throw UnimplementedError();

  @override
  bool get isSynchronous => throw UnimplementedError();

  @override
  bool get isSynthetic => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  Source get librarySource => throw UnimplementedError();

  @override
  ElementLocation? get location => throw UnimplementedError();

  @override
  List<ElementAnnotation> get metadata => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  int get nameLength => throw UnimplementedError();

  @override
  int get nameOffset => throw UnimplementedError();

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  List<ParameterElement> get parameters => throw UnimplementedError();

  @override
  DartType get returnType => throw UnimplementedError();

  @override
  AnalysisSession? get session => throw UnimplementedError();

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
  FunctionType get type => throw UnimplementedError();

  @override
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  PropertyInducingElement get variable => throw UnimplementedError();

  @override
  void visitChildren(ElementVisitor visitor) {}
}
