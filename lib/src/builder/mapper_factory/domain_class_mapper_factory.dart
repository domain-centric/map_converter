import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:logging/logging.dart';
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/mapper_factory/mapper_factory.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:recase/recase.dart';

class DomainClassMapperFactory implements MapperFactory {
  final Set<ClassElement> _classesBeingChecked = Set.identity();

  DomainClassMeta? _createDomainClassMeta(Element element) {
    if (!isDomainClass(element)) {
      return null;
    }
    var classElement = element as ClassElement;
    final mapConverterAnnotation = findMapConverterAnnotation(classElement);
    if (mapConverterAnnotation == null) {
      return null;
    }
    var fields = _createFields(classElement, mapConverterAnnotation);
    if (fields.isEmpty) {
      return null;
    }
    var bestConstructor =
        BestConstructorFactory().createFor(classElement, fields);
    var fieldsThatAreNotSet = findFieldsThatAreNotSet(fields, bestConstructor);
    validateIfAllFieldsAreSet(fieldsThatAreNotSet, classElement);
    var generateOptions = _generateOptions(classElement);
    if (fieldsThatAreNotSet.length == fields.length) {
      return null;
    }

    var discriminatorKey = findDiscriminatorKey(classElement);
    return DomainClassMeta(classElement, bestConstructor, fields,
        discriminatorKey, generateOptions);
  }

  void validateIfAllFieldsAreSet(
      List<FieldMetadata> fieldsThatAreNotSet, ClassElement classElement) {
    if (fieldsThatAreNotSet.isNotEmpty) {
      var fieldNamesThatAreNotSet =
          fieldsThatAreNotSet.map((field) => field.element.name).join(', ');
      log.log(
          Level.WARNING,
          'Class: ${classElement.name} '
          'contains fields that could not be set: $fieldNamesThatAreNotSet');
    }
  }

  bool isDomainClass(Element element) {
    if (element is! ClassElement) return false;
    var mapConverterAnnotation = findMapConverterAnnotation(element);
    if (mapConverterAnnotation == null) return false;

    if (mapConverterAnnotation.getField('includeSubClasses') == null) {
      return false;
    }
    return element.isPublic &&
        !element.isAbstract &&
        element is! EnumElement &&
        element.thisType.allSupertypes
            .none((e) => isListSetMapIteratorType(e.element));
  }

  /// Gets all fields that represent properties from the [InterfaceElement]
  /// including those from super classes, mixins and interfaces
  List<FieldElement> _findAllPublicFields(InterfaceElement interfaceElement) {
    Map<String, FieldElement> fields = {};
    for (var element in interfaceElement.fields) {
      if (_isPublicPropertyField(element)) {
        fields[element.name!] = element;
      }
    }
    for (var superType in interfaceElement.allSupertypes) {
      var superTypeFields = _findAllPublicFields(superType.element);
      for (var superTypeField in superTypeFields) {
        fields[superTypeField.name!] = superTypeField;
      }
    }
    return fields.values.toList();
  }

  List<FieldMetadata> _createFields(
      ClassElement classElement, DartObject? mapConverterAnnotation) {
    var fieldMetaData = <FieldMetadata>[];
    var fields = _findAllPublicFields(classElement);
    var fieldAnnotations = _findFieldAnnotations(mapConverterAnnotation);
    for (var field in fields) {
      var fieldAnnotation = findFieldAnnotation(fieldAnnotations, field);
      var ignore = fieldAnnotation?.getField('ignore')?.toBoolValue() ?? false;
      if (ignore) {
        continue;
      }
      var fieldPath = '${classElement.name}.${field.name}';
      try {
        var fieldType = field.type as InterfaceType;
        var valueExpressionFactory =
            ValueExpressionFactories().findFor(fieldType);
        var alias = fieldAnnotation?.getField('alias')?.toStringValue();
        var fromMapValueExpressionFunction =
            createFromMapValueExpressionFunction(
                fieldAnnotation, valueExpressionFactory);
        var toMapValueExpressionFunction = createToMapValueExpressionFunction(
            fieldAnnotation, valueExpressionFactory);

        if (fromMapValueExpressionFunction == null &&
            toMapValueExpressionFunction == null) {
          var isClass = fieldType.element is ClassElement;
          var hint = isClass
              ? 'Annotate class $fieldType with a @MapConveyor annotation.'
              : 'You could add a custom converter in the ${classElement.name} @MapConveyor annotation (see fields argument)';
          log.log(
              Level.WARNING,
              'Property: $fieldPath '
              'has an unsupported type: $fieldType. '
              '$hint');
        } else {
          var fieldExpressionFactory = FieldMetadata(
            field,
            alias: alias,
            fromMapValueExpressionFunction: fromMapValueExpressionFunction,
            toMapValueExpressionFunction: toMapValueExpressionFunction,
          );
          fieldMetaData.add(fieldExpressionFactory);
        }
      } on Exception catch (e) {
        throw Exception('$fieldPath: $e');
      }
    }

    return fieldMetaData;
  }

  /// Finds the

  DartObject? findFieldAnnotation(
      List<DartObject>? fieldAnnotations, FieldElement field) {
    return fieldAnnotations?.firstWhereOrNull((dartObject) =>
        (dartObject.getField('symbol')?.toSymbolValue()) == field.name);
  }

  FromMapValueExpressionFunction? createFromMapValueExpressionFunction(
      DartObject? fieldAnnotation,
      ValueExpressionFactory? valueExpressionFactory) {
    var fromMapValueCustomFunction =
        fieldAnnotation?.getField('fromMapValue')?.toFunctionValue();
    if (fromMapValueCustomFunction == null && valueExpressionFactory == null) {
      return null;
    }
    if (fromMapValueCustomFunction != null) {
      return createCustomFromMapValueExpressionFunction(
          functionName: fromMapValueCustomFunction.name!,
          functionLibraryUri: createRelativeLibraryUri(
              fromMapValueCustomFunction.library.uri.toString()));
    } else {
      return valueExpressionFactory!.fromMapValue;
    }
  }

  ToMapValueExpressionFunction? createToMapValueExpressionFunction(
      DartObject? fieldAnnotation,
      ValueExpressionFactory? valueExpressionFactory) {
    var toMapValueExpressionFunction =
        fieldAnnotation?.getField('toMapValue')?.toFunctionValue();
    if (toMapValueExpressionFunction == null &&
        valueExpressionFactory == null) {
      return null;
    }
    if (toMapValueExpressionFunction != null) {
      return createCustomToMapValueExpressionFunction(
          functionName: toMapValueExpressionFunction.name!,
          functionLibraryUri: createRelativeLibraryUri(
              toMapValueExpressionFunction.library.uri.toString()));
    } else {
      return valueExpressionFactory!.toMapValue;
    }
  }

  List<DartObject>? _findFieldAnnotations(DartObject? mapConverterAnnotation) =>
      mapConverterAnnotation?.getField('fields')?.toListValue();

  bool _isPublicPropertyField(FieldElement element) =>
      element.isPublic &&
      !element.isAbstract &&
      !element.isStatic &&
      !element.isConst &&
      (element.setter != null || _isSetInConstructor(element)) &&
      element.type is InterfaceType;

  bool _isSetInConstructor(FieldElement element) => element.isFinal;

  DartObject? _findMapConverterAnnotation(Element element) {
    for (var annotation in element.metadata.annotations) {
      var constantValue = annotation.computeConstantValue();
      if (constantValue?.type?.element?.name == "MapConverter") {
        return constantValue!;
      }
    }
    return null;
  }

  List<FieldMetadata> findFieldsThatAreNotSet(
      List<FieldMetadata> fields, Constructor bestConstructor) {
    var fieldsSetByConstructor = bestConstructor.fieldsBeingSet;
    var fieldsWithSetter =
        fields.where((field) => field.element.setter != null);
    var fieldsThatAreNotSet = [...fields]..removeWhere((field) =>
        fieldsSetByConstructor.contains(field) ||
        fieldsWithSetter.contains(field));
    return fieldsThatAreNotSet;
  }

  int _generateOptions(ClassElement classElement) {
    var annotation = _findMapConverterAnnotation(classElement);
    var generateOptions =
        annotation?.getField('generateOptions')?.toIntValue() ??
            GenerateOptions.all;
    return generateOptions;
  }

  @override
  bool supports(Element element) {
    if (element is! ClassElement) {
      return false;
    }
    if (!_classesBeingChecked.add(element)) {
      return true;
    }
    try {
      return _createDomainClassMeta(element) != null;
    } finally {
      _classesBeingChecked.remove(element);
    }
  }

  @override
  code.Class create(
      Element element, MapConverterLibraryAssetIdFactory idFactory) {
    var domainClassMeta = _createDomainClassMeta(element)!;
    return DomainClassMapperClass(domainClassMeta, idFactory);
  }
}

/// Contains information on a [DomainClassMeta] to generate [MapConverter]s
class DomainClassMeta {
  final ClassElement classElement;
  final Constructor bestConstructor;
  final String? discriminatorKey;
  final List<FieldMetadata> fields;
  final List<FieldMetadata> fieldsSetBySetter;
  final int generateOptions;
  late final bool generateFromMapValueMethod =
      generateOptions & GenerateOptions.fromMap > 0;
  late final bool generateToMapValueMethod =
      generateOptions & GenerateOptions.toMap > 0;
  late final bool generateSchemaField =
      generateOptions & GenerateOptions.schema > 0;

  DomainClassMeta(
    this.classElement,
    this.bestConstructor,
    this.fields,
    this.discriminatorKey,
    this.generateOptions,
  ) : fieldsSetBySetter = fields
            .where((field) =>
                !bestConstructor.fieldsBeingSet.contains(field) &&
                field.element.setter != null)
            .toList();
}

class Constructor {
  late String? name;
  final List<FieldMetadata> requiredPositionalParameters;
  final List<FieldMetadata> namedParameters;
  final List<FieldMetadata> optionalParameters;
  late Set<FieldMetadata> fieldsBeingSet;

  Constructor({
    String? name,
    required this.requiredPositionalParameters,
    required this.namedParameters,
    required this.optionalParameters,
  }) {
    this.name = (name == null || name.isEmpty) ? null : name;
    fieldsBeingSet = {};
    fieldsBeingSet.addAll(requiredPositionalParameters);
    fieldsBeingSet.addAll(namedParameters);
    fieldsBeingSet.addAll(optionalParameters);
  }

  Constructor.withoutParameters()
      : name = null,
        requiredPositionalParameters = [],
        namedParameters = [],
        optionalParameters = [],
        fieldsBeingSet = {};
}

class FieldMetadata {
  final FieldElement element;
  final String? alias;
  final ToMapValueExpressionFunction? toMapValueExpressionFunction;
  final FromMapValueExpressionFunction? fromMapValueExpressionFunction;

  FieldMetadata(this.element,
      {this.alias,
      required this.toMapValueExpressionFunction,
      required this.fromMapValueExpressionFunction});
}

class DomainClassMapperClass extends code.Class {
  DomainClassMapperClass(
      DomainClassMeta domainClass, MapConverterLibraryAssetIdFactory idFactory)
      : super(_name(domainClass), constructors: [
          _constructor(domainClass)
        ], methods: [
          if (domainClass.generateFromMapValueMethod)
            FromMapValueMethod(domainClass, idFactory),
          if (domainClass.generateToMapValueMethod)
            ToMapValueMethod(domainClass, idFactory)
        ], fields: [
          if (domainClass.generateSchemaField)
            SchemaField(domainClass, idFactory)
        ]);

  static String _name(DomainClassMeta domainClass) =>
      '${domainClass.classElement.name!}Mapper';

  static code.Constructor _constructor(DomainClassMeta domainClass) =>
      code.Constructor(code.Type(_name(domainClass)), constant: true);
}

class ToMapValueMethod extends code.Method {
  ToMapValueMethod(
    DomainClassMeta domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) : super(
          'toMap',
          _createBody(domainClass, idFactory),
          parameters: _createParameters(domainClass),
          returnType: _createReturnType(),
        );

  static code.CodeNode _createBody(
    DomainClassMeta domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) {
    Map<code.Expression, code.Expression> map = {};

    if (domainClass.discriminatorKey != null) {
      map[code.Expression.ofString(domainClass.discriminatorKey!)] =
          code.Expression.ofString(domainClass.classElement.name!);
    }

    for (var field in domainClass.fields.where((f) =>
        f.element.name != null && f.toMapValueExpressionFunction != null)) {
      var fieldName =
          code.Expression.ofString(field.alias ?? field.element.name!);
      var fieldType = field.element.type as InterfaceType;
      var instanceVariableName = domainClass.classElement.name!.camelCase;
      var source = code.Expression.ofVariable(instanceVariableName)
          .getProperty(field.element.name!);
      var fieldValueExpression = field.toMapValueExpressionFunction!(
        idFactory,
        source,
        fieldType,
      );
      map[fieldName] = fieldValueExpression;
    }
    return code.Expression.ofMap(map);
  }

  static code.Parameters _createParameters(DomainClassMeta domainClass) =>
      code.Parameters([
        code.Parameter.required(
          domainClass.classElement.name!.camelCase,
          type: createDomainType(domainClass),
        ),
      ]);

  static code.Type _createReturnType() => code.Type.ofMap(
      keyType: code.Type.ofString(), valueType: code.Type.ofDynamic());
}

class FromMapValueMethod extends code.Method {
  FromMapValueMethod(
    DomainClassMeta domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) : super(
          'fromMap',
          _createBody(domainClass, idFactory),
          parameters: _createFunctionParameters(domainClass),
          returnType: createDomainType(domainClass),
        );

  static code.CodeNode _createBody(
    DomainClassMeta domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) {
    var domainMapVariableName = _domainMapVariableName(domainClass);
    var constructorCall = _createConstructorCall(
      domainClass,
      idFactory,
    );
    for (var field in domainClass.fieldsSetBySetter) {
      var propertyName = field.alias ?? field.element.name!;
      var propertyValue = propertyValueExpression(
        field,
        idFactory,
        domainMapVariableName,
      );
      constructorCall = constructorCall.setProperty(
        propertyName,
        propertyValue,
        cascade: true,
      );
    }
    return constructorCall;
  }

  static code.Expression _createConstructorCall(DomainClassMeta domainClass,
      MapConverterLibraryAssetIdFactory idFactory) {
    var name = domainClass.bestConstructor.name;
    if (name == 'new') {
      name = null;
    }
    var parameters = _createConstructorParameterValues(domainClass, idFactory);
    return code.Expression.callConstructor(createDomainType(domainClass),
        name: name, parameterValues: parameters);
  }

  static code.Parameters _createFunctionParameters(
          DomainClassMeta domainClass) =>
      code.Parameters([
        code.Parameter.required(
          _domainMapVariableName(domainClass),
          type: code.Type.ofMap(
              keyType: code.Type.ofString(), valueType: code.Type.ofDynamic()),
        ),
      ]);

  static String _domainMapVariableName(DomainClassMeta domainClass) =>
      '${domainClass.classElement.name!.camelCase}Map';

  static code.ParameterValues _createConstructorParameterValues(
    DomainClassMeta domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) {
    var bestConstructor = domainClass.bestConstructor;
    String mapVariableName = _domainMapVariableName(domainClass);
    var parameterValues = <code.ParameterValue>[];
    for (var parameter in bestConstructor.requiredPositionalParameters) {
      code.Expression valueExpression =
          propertyValueExpression(parameter, idFactory, mapVariableName);
      parameterValues.add(code.ParameterValue(valueExpression));
    }
    for (var parameter in bestConstructor.optionalParameters) {
      code.Expression valueExpression =
          propertyValueExpression(parameter, idFactory, mapVariableName);
      parameterValues.add(code.ParameterValue(valueExpression));
    }
    for (var parameter in bestConstructor.namedParameters) {
      code.Expression valueExpression =
          propertyValueExpression(parameter, idFactory, mapVariableName);
      parameterValues.add(
          code.ParameterValue.named(parameter.element.name!, valueExpression));
    }
    return code.ParameterValues(parameterValues);
  }
}

code.Type createDomainType(DomainClassMeta domainClass) => code.Type(
      domainClass.classElement.name!,
      libraryUri: createLibraryUri(domainClass.classElement),
    );

code.Expression propertyValueExpression(FieldMetadata field,
    MapConverterLibraryAssetIdFactory idFactory, String mapVariableName) {
  var fieldName = field.alias ?? field.element.name!;
  var fieldType = field.element.type as InterfaceType;
  var source = code.Expression.ofVariable(mapVariableName)
      .index(code.Expression.ofString(fieldName));
  var valueExpression = field.fromMapValueExpressionFunction!(
    idFactory,
    source,
    fieldType,
  );

  return valueExpression;
}
