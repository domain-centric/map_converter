// ignore: depend_on_referenced_packages
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/source/source.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_provider.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:analyzer/dart/element/type_visitor.dart';
import 'package:analyzer/src/dart/ast/ast.dart' hide ConstructorInvocation;
import 'package:analyzer/src/dart/resolver/scope.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:build/src/asset_id.dart';
import 'package:build/src/builder.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:pub_semver/src/version.dart';

const _person = "Person";

class TypeFake implements InterfaceType {
  final String typeAsString;
  @override
  final bool isDartCoreType;
  final String libraryUrl;
  @override
  List<DartType> typeArguments = [];
  final bool nullable;

  TypeFake({
    required this.typeAsString,
    required this.isDartCoreType,
    required this.libraryUrl,
    this.nullable = false,
  });

  TypeFake.mapConverter({this.nullable = false})
      : typeAsString = "MapConverter",
        isDartCoreType = false,
        libraryUrl = '';

  TypeFake.bool({this.nullable = false})
      : typeAsString = "bool",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.num({this.nullable = false})
      : typeAsString = "num",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.int({this.nullable = false})
      : typeAsString = "int",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.double({this.nullable = false})
      : typeAsString = "double",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.string({this.nullable = false})
      : typeAsString = "String",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.uri({this.nullable = false})
      : typeAsString = "Uri",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.bigInt({this.nullable = false})
      : typeAsString = "BigInt",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.dateTime({this.nullable = false})
      : typeAsString = "DateTime",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.duration({this.nullable = false})
      : typeAsString = "Duration",
        isDartCoreType = true,
        libraryUrl = '';

  TypeFake.genderEnum({this.nullable = false})
      : typeAsString = "Gender",
        isDartCoreType = false,
        libraryUrl = 'person/person.dart';

  TypeFake.personClass({this.nullable = false})
      : typeAsString = _person,
        isDartCoreType = false,
        libraryUrl = 'person/person.dart';

  TypeFake.list(TypeFake genericType, {this.nullable = false})
      : typeAsString = "List",
        isDartCoreType = true,
        libraryUrl = '',
        typeArguments = [genericType];

  TypeFake.set(TypeFake genericType, {this.nullable = false})
      : typeAsString = "Set",
        isDartCoreType = true,
        libraryUrl = '',
        typeArguments = [genericType];

  TypeFake.map(TypeFake keyType, TypeFake valueType, {this.nullable = false})
      : typeAsString = "Map",
        isDartCoreType = true,
        libraryUrl = '',
        typeArguments = [keyType, valueType];

  TypeFake.customConverter({this.nullable = false})
      : typeAsString = 'MyCustomConverter',
        isDartCoreType = false,
        libraryUrl = 'person/person.dart';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeFake &&
          runtimeType == other.runtimeType &&
          typeAsString == other.typeAsString &&
          isDartCoreType == other.isDartCoreType &&
          libraryUrl == other.libraryUrl &&
          typeArguments == other.typeArguments;

  @override
  int get hashCode =>
      typeAsString.hashCode ^
      isDartCoreType.hashCode ^
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
  InterfaceElement get element {
    if (typeAsString == _person) {
      return PersonElementFake();
    } else {
      return InterfaceElementFake(this);
    }
  }

  @override
  MethodElement? getMethod(String name) {
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
  bool get isDartCoreMap => typeAsString == 'Map';

  @override
  bool get isDartCoreNull => throw UnimplementedError();

  @override
  bool get isDartCoreNum => typeAsString == 'num';

  @override
  bool get isDartCoreObject => throw UnimplementedError();

  @override
  bool get isDartCoreSet => typeAsString == 'Set';

  @override
  bool get isDartCoreString => typeAsString == 'String';

  @override
  bool get isDartCoreSymbol => throw UnimplementedError();

  @override
  ConstructorElement? lookUpConstructor(String? name, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  List<MethodElement> get methods => throw UnimplementedError();

  @override
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  String? get name => typeAsString;

  @override
  NullabilitySuffix get nullabilitySuffix =>
      nullable ? NullabilitySuffix.question : NullabilitySuffix.none;

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

  @override
  DartType get extensionTypeErasure => throw UnimplementedError();

  @override
  List<GetterElement> get getters => throw UnimplementedError();

  @override
  List<SetterElement> get setters => throw UnimplementedError();

  // @override
  // String getDisplayString({bool withNullability = true}) =>
  //     "$typeAsString${withNullability ? '?' : ''}";

  // @override
  // GetterElement? lookUpGetter3(String name, LibraryElement2 library,
  //     {bool concrete = false,
  //     bool inherited = false,
  //     bool recoveryStatic = false}) {
  //   throw UnimplementedError();
  // }

  // @override
  // MethodElement2? lookUpMethod3(String name, LibraryElement2 library,
  //     {bool concrete = false,
  //     bool inherited = false,
  //     bool recoveryStatic = false}) {
  //   throw UnimplementedError();
  // }

  // @override
  // SetterElement? lookUpSetter3(String name, LibraryElement2 library,
  //     {bool concrete = false,
  //     bool inherited = false,
  //     bool recoveryStatic = false}) {
  //   throw UnimplementedError();
  // }

  @override
  Map<Name, ExecutableElement> get inheritedConcreteMembers =>
      throw UnimplementedError();

  @override
  Map<Name, ExecutableElement> get interfaceMembers =>
      throw UnimplementedError();

  @override
  GetterElement? lookUpGetter(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  SetterElement? lookUpSetter(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  GetterElement? getGetter(String name) {
    throw UnimplementedError();
  }

  @override
  SetterElement? getSetter(String name) {
    throw UnimplementedError();
  }

  @override
  String getDisplayString(
          {bool withNullability = true,
          bool includePositionalParameterNames = false}) =>
      "$typeAsString${withNullability ? '?' : ''}";
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
  List<InterfaceType> get allSupertypes => throw UnimplementedError();

  @override
  List<ConstructorElement> get constructors => throw UnimplementedError();

  @override
  String get displayName => typeFake.typeAsString;

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  List<FieldElement> get fields => throw UnimplementedError();

  @override
  FieldElement? getField(String name) {
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
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => throw UnimplementedError();

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => LibraryElementFake(typeFake);

  @override
  MethodElement? lookUpConcreteMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  List<MethodElement> get methods => throw UnimplementedError();

  @override
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  String get name => typeFake.typeAsString;

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  AnalysisSession? get session => throw UnimplementedError();

  @override
  InterfaceType? get supertype => throw UnimplementedError();

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
  String toString() => typeFake.typeAsString == 'Gender'
      ? 'enum Gender'
      : 'class ${typeFake.typeAsString}';

  @override
  List<Element> get children => throw UnimplementedError();

  @override
  Version? get sinceSdkVersion => throw UnimplementedError();

  @override
  InstanceElement get baseElement => throw UnimplementedError();

  @override
  String displayString(
      {bool multiline = false,
      bool preferTypeAlias = false,
      bool includePositionalParameterNames = false}) {
    throw UnimplementedError();
  }

  @override
  LibraryElement get enclosingElement => throw UnimplementedError();

  @override
  InterfaceFragment get firstFragment => throw UnimplementedError();

  @override
  List<InterfaceFragment> get fragments => throw UnimplementedError();

  @override
  ExecutableElement? getInheritedConcreteMember(Name name) {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? getInheritedMember(Name name) {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? getInterfaceMember(Name name) {
    throw UnimplementedError();
  }

  @override
  List<ExecutableElement>? getOverridden(Name name) {
    throw UnimplementedError();
  }

  @override
  List<GetterElement> get getters => throw UnimplementedError();

  @override
  Map<Name, ExecutableElement> get inheritedConcreteMembers =>
      throw UnimplementedError();

  @override
  Map<Name, ExecutableElement> get inheritedMembers =>
      throw UnimplementedError();

  @override
  Map<Name, ExecutableElement> get interfaceMembers =>
      throw UnimplementedError();

  @override
  bool isDeprecatedWithKind(String kind) {
    throw UnimplementedError();
  }

  @override
  String? get lookupName => throw UnimplementedError();

  @override
  ConstructorElement? get primaryConstructor => throw UnimplementedError();

  @override
  List<SetterElement> get setters => throw UnimplementedError();

  @override
  T? accept<T>(visitor) {
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName({String? shortName}) {
    throw UnimplementedError();
  }

  @override
  GetterElement? getGetter(String name) {
    throw UnimplementedError();
  }

  @override
  SetterElement? getSetter(String name) {
    throw UnimplementedError();
  }

  @override
  GetterElement? lookUpGetter(
      {required String name, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedMethod(
      {required String methodName, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod(
      {required String name, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  SetterElement? lookUpSetter(
      {required String name, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  Metadata get metadata =>
      MetaDataFake(hasMapConverterAnnotation: typeFake.name == _person);

  @override
  Element? thisOrAncestorMatching(bool Function(Element) predicate) {
    throw UnimplementedError();
  }

  @override
  void visitChildren<T>(visitor) {}
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
  String get displayName => throw UnimplementedError();

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  Namespace get exportNamespace => throw UnimplementedError();

  @override
  List<LibraryElement> get exportedLibraries => throw UnimplementedError();

  @override
  FeatureSet get featureSet => throw UnimplementedError();

  @override
  ClassElement? getClass(String name) {
    throw UnimplementedError();
  }

  @override
  int get id => throw UnimplementedError();

  @override
  String get identifier => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool get isDartAsync => throw UnimplementedError();

  @override
  bool get isDartCore => throw UnimplementedError();

  @override
  bool get isInSdk => throw UnimplementedError();

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryLanguageVersion get languageVersion => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  String get name => "dart.core";

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  Namespace get publicNamespace => throw UnimplementedError();

  @override
  AnalysisSession get session => throw UnimplementedError();

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    throw UnimplementedError();
  }

  @override
  TypeProvider get typeProvider => throw UnimplementedError();

  @override
  TypeSystem get typeSystem => throw UnimplementedError();

  @override
  List<Element> get children => throw UnimplementedError();

  @override
  Version? get sinceSdkVersion => throw UnimplementedError();

  @override
  T? accept<T>(visitor) {
    throw UnimplementedError();
  }

  @override
  Element get baseElement => throw UnimplementedError();

  @override
  List<ClassElement> get classes => throw UnimplementedError();

  @override
  String displayString(
      {bool multiline = false,
      bool preferTypeAlias = false,
      bool includePositionalParameterNames = false}) {
    throw UnimplementedError();
  }

  @override
  Element? get enclosingElement => throw UnimplementedError();

  @override
  TopLevelFunctionElement? get entryPoint => throw UnimplementedError();

  @override
  List<EnumElement> get enums => throw UnimplementedError();

  @override
  List<ExtensionTypeElement> get extensionTypes => throw UnimplementedError();

  @override
  List<ExtensionElement> get extensions => throw UnimplementedError();

  @override
  LibraryFragment get firstFragment => throw UnimplementedError();

  @override
  List<LibraryFragment> get fragments => throw UnimplementedError();

  @override
  EnumElement? getEnum(String name) {
    throw UnimplementedError();
  }

  @override
  String getExtendedDisplayName({String? shortName}) {
    throw UnimplementedError();
  }

  @override
  ExtensionElement? getExtension(String name) {
    throw UnimplementedError();
  }

  @override
  ExtensionTypeElement? getExtensionType(String name) {
    throw UnimplementedError();
  }

  @override
  GetterElement? getGetter(String name) {
    throw UnimplementedError();
  }

  @override
  MixinElement? getMixin(String name) {
    throw UnimplementedError();
  }

  @override
  SetterElement? getSetter(String name) {
    throw UnimplementedError();
  }

  @override
  TopLevelFunctionElement? getTopLevelFunction(String name) {
    throw UnimplementedError();
  }

  @override
  TopLevelVariableElement? getTopLevelVariable(String name) {
    throw UnimplementedError();
  }

  @override
  TypeAliasElement? getTypeAlias(String name) {
    throw UnimplementedError();
  }

  @override
  List<GetterElement> get getters => throw UnimplementedError();

  @override
  bool isDeprecatedWithKind(String kind) {
    throw UnimplementedError();
  }

  @override
  bool get isOriginNotExistingFile => throw UnimplementedError();

  @override
  TopLevelFunctionElement get loadLibraryFunction => throw UnimplementedError();

  @override
  String? get lookupName => throw UnimplementedError();

  @override
  Metadata get metadata => throw UnimplementedError();

  @override
  List<MixinElement> get mixins => throw UnimplementedError();

  @override
  List<SetterElement> get setters => throw UnimplementedError();

  @override
  Element? thisOrAncestorMatching(bool Function(Element) predicate) {
    throw UnimplementedError();
  }

  @override
  List<TopLevelFunctionElement> get topLevelFunctions =>
      throw UnimplementedError();

  @override
  List<TopLevelVariableElement> get topLevelVariables =>
      throw UnimplementedError();

  @override
  List<TypeAliasElement> get typeAliases => throw UnimplementedError();

  @override
  Uri get uri => Uri.parse(typeFake.libraryUrl);

  @override
  void visitChildren<T>(visitor) {}
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
  List<InterfaceType> get allSupertypes => [];

  @override
  List<ConstructorElement> get constructors => throw UnimplementedError();

  @override
  String get displayName => thisType.element.name ?? '';

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  List<FieldElement> get fields =>
      [FieldElementFake('name', TypeFake.string())];

  @override
  FieldElement? getField(String name) {
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
  bool get isDartCoreEnum => throw UnimplementedError();

  @override
  bool get isDartCoreObject => throw UnimplementedError();

  @override
  bool get isMixinApplication => throw UnimplementedError();

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => true;

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  bool get isValidMixin => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => LibraryElementFake(thisType as TypeFake);

  @override
  MethodElement? lookUpConcreteMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  T? accept<T>(visitor) {
    throw UnimplementedError();
  }

  @override
  InstanceElement get baseElement => throw UnimplementedError();

  @override
  List<Element> get children => throw UnimplementedError();

  @override
  String displayString(
      {bool multiline = false,
      bool preferTypeAlias = false,
      bool includePositionalParameterNames = false}) {
    throw UnimplementedError();
  }

  @override
  LibraryElement get enclosingElement => throw UnimplementedError();

  @override
  ClassFragment get firstFragment => throw UnimplementedError();

  @override
  List<ClassFragment> get fragments => throw UnimplementedError();

  @override
  String getExtendedDisplayName({String? shortName}) {
    throw UnimplementedError();
  }

  @override
  GetterElement? getGetter(String name) {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? getInheritedConcreteMember(Name name) {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? getInheritedMember(Name name) {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? getInterfaceMember(Name name) {
    throw UnimplementedError();
  }

  @override
  List<ExecutableElement>? getOverridden(Name name) {
    throw UnimplementedError();
  }

  @override
  SetterElement? getSetter(String name) {
    throw UnimplementedError();
  }

  @override
  List<GetterElement> get getters => throw UnimplementedError();

  @override
  bool get hasNonFinalField => throw UnimplementedError();

  @override
  Map<Name, ExecutableElement> get inheritedConcreteMembers =>
      throw UnimplementedError();

  @override
  Map<Name, ExecutableElement> get inheritedMembers =>
      throw UnimplementedError();

  @override
  Map<Name, ExecutableElement> get interfaceMembers =>
      throw UnimplementedError();

  @override
  bool get isBase => throw UnimplementedError();

  @override
  bool get isConstructable => throw UnimplementedError();

  @override
  bool isDeprecatedWithKind(String kind) {
    throw UnimplementedError();
  }

  @override
  bool get isExhaustive => throw UnimplementedError();

  @override
  bool get isExtendableOutside => throw UnimplementedError();

  @override
  bool get isFinal => throw UnimplementedError();

  @override
  bool get isImplementableOutside => throw UnimplementedError();

  @override
  bool get isInterface => throw UnimplementedError();

  @override
  bool get isMixableOutside => throw UnimplementedError();

  @override
  bool get isMixinClass => throw UnimplementedError();

  @override
  bool get isSealed => throw UnimplementedError();

  @override
  GetterElement? lookUpGetter(
      {required String name, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedMethod(
      {required String methodName, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod(
      {required String name, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  SetterElement? lookUpSetter(
      {required String name, required LibraryElement library}) {
    throw UnimplementedError();
  }

  @override
  String? get lookupName => throw UnimplementedError();

  @override
  Metadata get metadata => MetaDataFake(hasMapConverterAnnotation: true);

  @override
  List<MethodElement> get methods => throw UnimplementedError();

  @override
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  String? get name => 'Person';

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  ConstructorElement? get primaryConstructor => throw UnimplementedError();

  @override
  AnalysisSession? get session => throw UnimplementedError();

  @override
  List<SetterElement> get setters => throw UnimplementedError();

  @override
  Version? get sinceSdkVersion => throw UnimplementedError();

  @override
  InterfaceType? get supertype => throw UnimplementedError();

  @override
  Element? thisOrAncestorMatching(bool Function(Element) predicate) {
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
  void visitChildren<T>(visitor) {}

  //TODO ? @override
  // List<ElementAnnotation> get metadata =>
  //     [ElementAnnotationFake(TypeFake.mapConverter())];

  // TODO ? @override
  // String get name => 'Person';
}

class MetaDataFake extends Metadata {
  final bool hasMapConverterAnnotation;

  MetaDataFake({required this.hasMapConverterAnnotation});

  @override
  List<ElementAnnotation> get annotations => hasMapConverterAnnotation
      ? [ElementAnnotationFake(TypeFake.mapConverter())]
      : [];

  @override
  bool get hasAlwaysThrows => throw UnimplementedError();

  @override
  bool get hasAwaitNotRequired => throw UnimplementedError();

  @override
  bool get hasDeprecated => throw UnimplementedError();

  @override
  bool get hasDoNotStore => throw UnimplementedError();

  @override
  bool get hasDoNotSubmit => throw UnimplementedError();

  @override
  bool get hasExperimental => throw UnimplementedError();

  @override
  bool get hasFactory => throw UnimplementedError();

  @override
  bool get hasImmutable => throw UnimplementedError();

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
  bool get hasMustBeConst => throw UnimplementedError();

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
  bool get hasRedeclare => throw UnimplementedError();

  @override
  bool get hasReopen => throw UnimplementedError();

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
  bool get hasVisibleOutsideTemplate => throw UnimplementedError();

  @override
  bool get hasWidgetFactory => throw UnimplementedError();
}

class ElementAnnotationFake extends ElementAnnotation {
  final TypeFake typeFake;

  ElementAnnotationFake(this.typeFake);

  @override
  DartObject? computeConstantValue() => DartObjectFake(typeFake);

  @override
  Element? get element => throw UnimplementedError();

  @override
  bool get isAlwaysThrows => throw UnimplementedError();

  @override
  bool get isDeprecated => throw UnimplementedError();

  @override
  bool get isDoNotStore => throw UnimplementedError();

  @override
  bool get isDoNotSubmit => throw UnimplementedError();

  @override
  bool get isFactory => throw UnimplementedError();

  @override
  bool get isImmutable => throw UnimplementedError();

  @override
  bool get isInternal => throw UnimplementedError();

  @override
  bool get isIsTest => throw UnimplementedError();

  @override
  bool get isIsTestGroup => throw UnimplementedError();

  @override
  bool get isJS => throw UnimplementedError();

  @override
  bool get isLiteral => throw UnimplementedError();

  @override
  bool get isMustBeConst => throw UnimplementedError();

  @override
  bool get isMustBeOverridden => throw UnimplementedError();

  @override
  bool get isMustCallSuper => throw UnimplementedError();

  @override
  bool get isNonVirtual => throw UnimplementedError();

  @override
  bool get isOptionalTypeArgs => throw UnimplementedError();

  @override
  bool get isOverride => throw UnimplementedError();

  @override
  bool get isProtected => throw UnimplementedError();

  @override
  bool get isProxy => throw UnimplementedError();

  @override
  bool get isRedeclare => throw UnimplementedError();

  @override
  bool get isReopen => throw UnimplementedError();

  @override
  bool get isRequired => throw UnimplementedError();

  @override
  bool get isSealed => throw UnimplementedError();

  @override
  bool get isTarget => throw UnimplementedError();

  @override
  bool get isUseResult => throw UnimplementedError();

  @override
  bool get isVisibleForOverriding => throw UnimplementedError();

  @override
  bool get isVisibleForTemplate => throw UnimplementedError();

  @override
  bool get isVisibleForTesting => throw UnimplementedError();

  @override
  bool get isVisibleOutsideTemplate => throw UnimplementedError();

  @override
  String toSource() {
    throw UnimplementedError();
  }

  @override
  bool get isWidgetFactory => throw UnimplementedError();

  @override
  List<Diagnostic>? get constantEvaluationErrors => throw UnimplementedError();

  @override
  String? get deprecationKind => throw UnimplementedError();

  @override
  bool get isAwaitNotRequired => throw UnimplementedError();

  @override
  bool get isExperimental => throw UnimplementedError();

  @override
  bool? isValidAtElement(Element element) {
    throw UnimplementedError();
  }

  @override
  LibraryFragment get libraryFragment => throw UnimplementedError();
}

class DartObjectFake extends DartObject {
  final TypeFake typeFake;

  DartObjectFake(this.typeFake);

  @override
  DartObject? getField(String name) => DartObjectFake(typeFake);

  @override
  bool get hasKnownValue => throw UnimplementedError();

  @override
  bool get isNull => true;

  @override
  bool? toBoolValue() => false;

  @override
  double? toDoubleValue() {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? toFunctionValue() {
    throw UnimplementedError();
  }

  @override
  int? toIntValue() {
    throw UnimplementedError();
  }

  @override
  List<DartObject>? toListValue() => [DartObjectFake(typeFake)];

  @override
  Map<DartObject?, DartObject?>? toMapValue() {
    throw UnimplementedError();
  }

  @override
  Set<DartObject>? toSetValue() {
    throw UnimplementedError();
  }

  @override
  String? toStringValue() => 'Name';

  @override
  String? toSymbolValue() {
    throw UnimplementedError();
  }

  @override
  DartType? toTypeValue() => DartTypeFake(typeFake);

  @override
  DartType? get type => DartTypeFake(typeFake);

  @override
  VariableElement? get variable => throw UnimplementedError();

  @override
  ({Map<String, DartObject> named, List<DartObject> positional})?
      toRecordValue() {
    throw UnimplementedError();
  }

  @override
  DartType? toTypeValueNotExtensionTypeErased() {
    throw UnimplementedError();
  }

  @override
  DartType? get typeNotExtensionTypeErased => throw UnimplementedError();

  @override
  ConstructorInvocation? get constructorInvocation =>
      throw UnimplementedError();
}

class DartTypeFake extends DartType {
  final TypeFake typeFake;

  DartTypeFake(this.typeFake);

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
  InstantiatedTypeAliasElement? get alias => throw UnimplementedError();

  @override
  InterfaceType? asInstanceOf(InterfaceElement element) {
    throw UnimplementedError();
  }

  @override
  Element? get element => InterfaceElementFake(typeFake);

  @override
  DartType get extensionTypeErasure => throw UnimplementedError();

  @override
  bool get isBottom => throw UnimplementedError();

  @override
  bool get isDartAsyncFuture => throw UnimplementedError();

  @override
  bool get isDartAsyncFutureOr => throw UnimplementedError();

  @override
  bool get isDartAsyncStream => throw UnimplementedError();

  @override
  bool get isDartCoreBool => throw UnimplementedError();

  @override
  bool get isDartCoreDouble => throw UnimplementedError();

  @override
  bool get isDartCoreEnum => throw UnimplementedError();

  @override
  bool get isDartCoreFunction => throw UnimplementedError();

  @override
  bool get isDartCoreInt => throw UnimplementedError();

  @override
  bool get isDartCoreIterable => throw UnimplementedError();

  @override
  bool get isDartCoreList => throw UnimplementedError();

  @override
  bool get isDartCoreMap => throw UnimplementedError();

  @override
  bool get isDartCoreNull => throw UnimplementedError();

  @override
  bool get isDartCoreNum => throw UnimplementedError();

  @override
  bool get isDartCoreObject => throw UnimplementedError();

  @override
  bool get isDartCoreRecord => throw UnimplementedError();

  @override
  bool get isDartCoreSet => throw UnimplementedError();

  @override
  bool get isDartCoreString => throw UnimplementedError();

  @override
  bool get isDartCoreSymbol => throw UnimplementedError();

  @override
  bool get isDartCoreType => throw UnimplementedError();

  @override
  String? get name => throw UnimplementedError();

  @override
  NullabilitySuffix get nullabilitySuffix => throw UnimplementedError();

  @override
  String getDisplayString(
          {bool withNullability = true,
          bool includePositionalParameterNames = false}) =>
      typeFake.name ?? '';
}

class FieldElementFake extends FieldElement {
  @override
  final String name;
  @override
  final InterfaceType type;

  FieldElementFake(this.name, this.type);

  @override
  DartObject? computeConstantValue() {
    throw UnimplementedError();
  }

  @override
  String get displayName => throw UnimplementedError();

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  int get id => throw UnimplementedError();

  @override
  bool get isAbstract => false;

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool get isConst => false;

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
  bool get isPrivate => name.startsWith('_');

  @override
  bool get isPublic => true;

  @override
  bool get isStatic => false;

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  AnalysisSession? get session => throw UnimplementedError();

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    throw UnimplementedError();
  }

  @override
  List<Element> get children => throw UnimplementedError();

  @override
  bool get isPromotable => throw UnimplementedError();

  @override
  Version? get sinceSdkVersion => throw UnimplementedError();

  @override
  T? accept<T>(visitor) {
    throw UnimplementedError();
  }

  @override
  FieldElement get baseElement => throw UnimplementedError();

  @override
  Expression? get constantInitializer => throw UnimplementedError();

  @override
  Expression? get constantInitializer2 => throw UnimplementedError();

  @override
  FieldFormalParameterElement? get declaringFormalParameter =>
      throw UnimplementedError();

  @override
  String displayString(
      {bool multiline = false,
      bool preferTypeAlias = false,
      bool includePositionalParameterNames = false}) {
    throw UnimplementedError();
  }

  @override
  InstanceElement get enclosingElement => throw UnimplementedError();

  @override
  FieldFragment get firstFragment => throw UnimplementedError();

  @override
  List<FieldFragment> get fragments => throw UnimplementedError();

  @override
  String getExtendedDisplayName({String? shortName}) {
    throw UnimplementedError();
  }

  @override
  GetterElement? get getter => throw UnimplementedError();

  @override
  bool get hasImplicitType => throw UnimplementedError();

  @override
  bool get hasInitializer => throw UnimplementedError();

  @override
  bool isDeprecatedWithKind(String kind) {
    throw UnimplementedError();
  }

  @override
  bool get isOriginDeclaration => throw UnimplementedError();

  @override
  bool get isOriginDeclaringFormalParameter => throw UnimplementedError();

  @override
  bool get isOriginEnumValues => throw UnimplementedError();

  @override
  bool get isOriginExtensionTypeRecoveryRepresentation =>
      throw UnimplementedError();

  @override
  bool get isOriginGetterSetter => throw UnimplementedError();

  @override
  String? get lookupName => throw UnimplementedError();

  @override
  Metadata get metadata => throw UnimplementedError();

  @override
  Element? thisOrAncestorMatching(bool Function(Element) predicate) {
    throw UnimplementedError();
  }

  @override
  void visitChildren<T>(visitor) {}

  @override
  SetterElement? get setter => throw UnimplementedError();
}

class PropertyAccessorElementFake extends PropertyAccessorElement {
  @override
  String get displayName => throw UnimplementedError();

  @override
  String? get documentationComment => throw UnimplementedError();

  @override
  bool get hasImplicitReturnType => throw UnimplementedError();

  @override
  int get id => throw UnimplementedError();

  @override
  bool get isAbstract => throw UnimplementedError();

  @override
  bool isAccessibleIn(LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  bool get isExternal => throw UnimplementedError();

  @override
  bool get isPrivate => throw UnimplementedError();

  @override
  bool get isPublic => throw UnimplementedError();

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  bool get isStatic => throw UnimplementedError();

  @override
  ElementKind get kind => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  Element get nonSynthetic => throw UnimplementedError();

  @override
  DartType get returnType => throw UnimplementedError();

  @override
  AnalysisSession? get session => throw UnimplementedError();

  @override
  E? thisOrAncestorOfType<E extends Element>() {
    throw UnimplementedError();
  }

  @override
  FunctionType get type => throw UnimplementedError();

  @override
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  List<Element> get children => throw UnimplementedError();

  @override
  Version? get sinceSdkVersion => throw UnimplementedError();

  @override
  bool get isExtensionTypeMember => throw UnimplementedError();

  @override
  T? accept<T>(visitor) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement get baseElement => throw UnimplementedError();

  @override
  String displayString(
      {bool multiline = false,
      bool preferTypeAlias = false,
      bool includePositionalParameterNames = false}) {
    throw UnimplementedError();
  }

  @override
  Element get enclosingElement => throw UnimplementedError();

  @override
  PropertyAccessorFragment get firstFragment => throw UnimplementedError();

  @override
  List<FormalParameterElement> get formalParameters =>
      throw UnimplementedError();

  @override
  List<PropertyAccessorFragment> get fragments => throw UnimplementedError();

  @override
  String getExtendedDisplayName({String? shortName}) {
    throw UnimplementedError();
  }

  @override
  bool isDeprecatedWithKind(String kind) {
    throw UnimplementedError();
  }

  @override
  bool get isOriginDeclaration => throw UnimplementedError();

  @override
  bool get isOriginInterface => throw UnimplementedError();

  @override
  bool get isOriginVariable => throw UnimplementedError();

  @override
  String? get lookupName => throw UnimplementedError();

  @override
  Metadata get metadata => throw UnimplementedError();

  @override
  PropertyInducingElement get variable => throw UnimplementedError();

  @override
  Element? thisOrAncestorMatching(bool Function(Element) predicate) {
    throw UnimplementedError();
  }

  @override
  void visitChildren<T>(ElementVisitor2<T> visitor) {}
}
