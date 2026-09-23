import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:logging/logging.dart';
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:recase/recase.dart';

class MapConverterBuilder implements Builder {
  final BuilderOptions builderOptions;
  MapConverterBuilder(this.builderOptions);

  // /// Gets the input parameter of the options section in the build.yaml file.
  // /// The input tells the [MapConverterBuilder] which files to process.
  // /// See keys of [buildExtensions]
  // ///
  // /// Example of a build.yaml:
  // /// targets:
  // ///   $default:
  // ///     builders:
  // ///       map_converter|map_converter_builder:
  // ///         enabled: True
  // ///         options:
  // ///           input: ^lib/domain/{{}}.dart
  // ///           output: lib/domain/{{}}.data.converter.map.dart
  // String get input => (builderOptions.config['input'] ?? '').trim();

  // /// Gets the output parameter of the options section in the build.yaml file.
  // /// The output tells the [MapConverterBuilder] where to store the results.
  // /// See value of [buildExtensions]
  // ///
  // /// Example of a build.yaml:
  // /// targets:
  // ///   $default:
  // ///     builders:
  // ///       map_converter|map_converter_builder:
  // ///         enabled: True
  // ///         options:
  // ///           input: ^lib/domain/{{}}.dart
  // ///           output: lib/domain/{{}}.data.converter.map.dart
  // String get output => (builderOptions.config['output'] ?? '').trim();

  // @override
  // Map<String, List<String>> get buildExtensions {
  //   if (input.isEmpty) {
  //     log.log(
  //         Level.SEVERE,
  //         'input option in build.yaml file is not defined. '
  //         'See documentation on: https://pub.dev/packages/map_converter');
  //   }
  //   if (output.isEmpty) {
  //     log.log(
  //         Level.SEVERE,
  //         'output option in build.yaml file is not defined. '
  //         'See documentation on: https://pub.dev/packages/map_converter');
  //   }
  //   return {
  //     input: [output]
  //   };
  // }
  // {
  //   '^lib/domain/{{}}.dart': ['lib/data/{{}}_map_converter.dart']
  // };

  @override
  Future<FutureOr<void>> build(BuildStep buildStep) async {
    try {
      var idFactory = MapConverterLibraryAssetIdFactory(this);
      var libraryElement = await buildStep.inputLibrary;
      var library =
          MapConverterLibraryFactory().create(idFactory, libraryElement);

      if (library == null) {
        // log.log(Level.SEVERE, 'Library is empty!');
      } else {
        AssetId outputId = idFactory.createOutputId(buildStep.inputId);
        var dartCode = library.toFormattedString();
        buildStep.writeAsString(outputId, dartCode);
        log.log(Level.INFO, 'Written: $outputId!');
      }
    } catch (e, stackTrace) {
      log.log(
          Level.SEVERE,
          'Error processing: ${buildStep.inputId.path}. Error: \n$e',
          stackTrace);
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '^{{}}.dart': ['{{}}_map_converter.dart']
      };
}

class MapConverterLibraryAssetIdFactory {
  final Builder builder;

  MapConverterLibraryAssetIdFactory(this.builder);

  /// [inputId] is the library file of the domain object(s).
  /// This will be converted to the library file that will
  /// contain the [MapConverter] for these domain object(s).
  AssetId createOutputId(AssetId inputId) {
    var assetIds = expectedOutputs(builder, inputId);
    var assetId = assetIds.first;
    return assetId;
  }

  String createOutputUriForType(InterfaceType domainObjectType) {
    var inputLibraryUri = domainObjectType.element.library.uri;
    var inputLibraryAssetId = AssetId.resolve(inputLibraryUri);
    var outputLibraryAssetId = createOutputId(inputLibraryAssetId);
    return outputLibraryAssetId.uri.toString();
  }
}

class MapConverterLibraryFactory {
  code.Library? create(MapConverterLibraryAssetIdFactory idFactory,
      LibraryElement libraryElement) {
    var domainClasses = DomainClassFactory().create(libraryElement);
    if (domainClasses.isEmpty) {
      return null;
    } else {
      return code.Library(
        docComments: _createDocComments(libraryElement),
        functions: _createFunctions(domainClasses, idFactory),
      );
    }
  }

  List<code.DartFunction> _createFunctions(
    List<DomainClass> domainClasses,
    MapConverterLibraryAssetIdFactory idFactory,
  ) {
    var functions = <code.DartFunction>[];
    for (var domainClass in domainClasses) {
      functions
          .add(MapToObjectFunctionFactory().create(domainClass, idFactory));
      functions
          .add(ObjectToMapFunctionFactory().create(domainClass, idFactory));
    }
    return functions;
  }

  List<code.DocComment> _createDocComments(LibraryElement libraryElement) => [
        code.DocComment.fromList([
          'Do not make changes to this file!',
          'This file is generated by package: map_converter',
          'Input: ${libraryElement.uri.toString().replaceAll(RegExp(r'^asset:'), '')}',
          'Generate command: '
              'dart run build_runner build --delete-conflicting-outputs',
          'For more information see: https://pub.dev/packages/map_converter',
        ])
      ];
}

class ObjectToMapFunctionFactory {
  code.DartFunction create(
    DomainClass domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) {
    return code.DartFunction.withName(
      _createName(domainClass),
      _createBody(domainClass, idFactory),
      parameters: _createParameters(domainClass),
      returnType: _createReturnType(),
    );
  }

  String _createName(DomainClass domainClass) =>
      '${domainClass.element.displayName.camelCase}ToMap';

  code.CodeNode _createBody(
    DomainClass domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) {
    Map<code.Expression, code.Expression> map = {};
    for (var field in domainClass.fields.where((f) =>
        f.element.name != null &&
        f.objectToMapValueExpressionFunction != null)) {
      var fieldName =
          code.Expression.ofString(field.alias ?? field.element.name!);
      var fieldType = field.element.type as InterfaceType;
      var instanceVariableName = domainClass.element.name!.camelCase;
      var source = code.Expression.ofVariable(instanceVariableName)
          .getProperty(field.element.name!);
      var fieldValueExpression = field.objectToMapValueExpressionFunction!(
        idFactory,
        source,
        fieldType,
      );
      map[fieldName] = fieldValueExpression;
    }
    return code.Expression.ofMap(map);
  }

  code.Parameters _createParameters(DomainClass domainClass) =>
      code.Parameters([
        code.Parameter.required(
          domainClass.element.name!.camelCase,
          type: createDomainType(domainClass),
        ),
      ]);

  code.Type _createReturnType() => code.Type.ofMap(
      keyType: code.Type.ofString(), valueType: code.Type.ofDynamic());
}

class MapToObjectFunctionFactory {
  code.DartFunction create(
    DomainClass domainClass,
    MapConverterLibraryAssetIdFactory idFactory,
  ) {
    return code.DartFunction.withName(
      _createName(domainClass),
      _createBody(domainClass, idFactory),
      parameters: _createFunctionParameters(domainClass),
      returnType: createDomainType(domainClass),
    );
  }

  String _createName(DomainClass domainClass) =>
      'mapTo${domainClass.element.displayName}';

  code.CodeNode _createBody(
    DomainClass domainClass,
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

  code.Expression _createConstructorCall(
      DomainClass domainClass, MapConverterLibraryAssetIdFactory idFactory) {
    var name = domainClass.bestConstructor.name;
    if (name == 'new') {
      name = null;
    }
    var parameters = _createConstructorParameterValues(domainClass, idFactory);
    return code.Expression.callConstructor(createDomainType(domainClass),
        name: name, parameterValues: parameters);
  }

  code.Parameters _createFunctionParameters(DomainClass domainClass) =>
      code.Parameters([
        code.Parameter.required(
          _domainMapVariableName(domainClass),
          type: code.Type.ofMap(
              keyType: code.Type.ofString(), valueType: code.Type.ofDynamic()),
        ),
      ]);

  String _domainMapVariableName(DomainClass domainClass) =>
      '${domainClass.element.name!.camelCase}Map';

  code.ParameterValues _createConstructorParameterValues(
    DomainClass domainClass,
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

code.Type createDomainType(DomainClass domainClass) => code.Type(
      domainClass.element.name!,
      libraryUri: createLibraryUri(domainClass.element),
    );

code.Expression propertyValueExpression(FieldMetadata field,
    MapConverterLibraryAssetIdFactory idFactory, String mapVariableName) {
  var fieldName = field.alias ?? field.element.name!;
  var fieldType = field.element.type as InterfaceType;
  var source = code.Expression.ofVariable(mapVariableName)
      .index(code.Expression.ofString(fieldName));
  var valueExpression = field.mapValueToObjectExpressionFunction!(
    idFactory,
    source,
    fieldType,
  );
  return valueExpression;
}

/// Contains information on a [DomainClass] to generate [MapConverter]s
class DomainClass {
  final ClassElement element;
  final Constructor bestConstructor;
  final List<FieldMetadata> fields;
  final List<FieldMetadata> fieldsSetBySetter;

  DomainClass(
    this.element,
    this.bestConstructor,
    this.fields,
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
  final ObjectToMapValueExpressionFunction? objectToMapValueExpressionFunction;
  final MapValueToObjectExpressionFunction? mapValueToObjectExpressionFunction;

  FieldMetadata(this.element,
      {this.alias,
      required this.objectToMapValueExpressionFunction,
      required this.mapValueToObjectExpressionFunction});
}

typedef ObjectToMapValueExpressionFunction =

    /// Creates a Dart code expressions for a generated MapConverter
    /// to convert a [source] object to a [PrimitiveType]
    code.Expression Function(
  MapConverterLibraryAssetIdFactory idFactory,

  /// [source]: An expression of the source data, e.g.:
  /// * person.name (a field or property value of an object)
  /// * enumValue
  /// * listElement
  /// * setElement
  /// * k (for a key value in a [Map])
  /// * v (for a value in a [Map])
  code.Expression source,
  InterfaceType typeToConvert,
);

typedef MapValueToObjectExpressionFunction =

    /// Creates a Dart code expressions for a generated MapConverter
    /// to convert a [PrimitiveType] to an object
    code.Expression Function(
  MapConverterLibraryAssetIdFactory idFactory,

  /// [source]: An expression of the source data, e.g.:
  /// * personMap['propertyName'] (a [PrimitiveType] within a [Map])
  /// * enumValue
  /// * listElement
  /// * setElement
  /// * k (for a key value in a [Map])
  /// * v (for a value in a [Map])
  code.Expression source,
  InterfaceType typeToConvert,
);

class DomainClassFactory {
  List<DomainClass> create(LibraryElement libraryElement) {
    var domainClasses = <DomainClass>[];
    var topElements = libraryElement.children;
    for (var topElement in topElements) {
      if (isDomainClass(topElement)) {
        var classElement = topElement as ClassElement;
        var fields = _createFields(classElement);
        if (fields.isNotEmpty) {
          var bestConstructor =
              BestConstructorFactory().createFor(classElement, fields);
          var fieldsThatAreNotSet =
              findFieldsThatAreNotSet(fields, bestConstructor);
          validateIfAllFieldsAreSet(fieldsThatAreNotSet, classElement);
          if (fieldsThatAreNotSet.length != fields.length) {
            var domainClass =
                DomainClass(classElement, bestConstructor, fields);
            domainClasses.add(domainClass);
          }
        }
      }
    }
    return domainClasses;
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
    return _hasMapConverterAnnotation(element) &&
        element is ClassElement &&
        element.isPublic &&
        !element.isAbstract &&
        element is! EnumElement &&
        element.thisType.allSupertypes
            .none((e) => _isListSetMapIteratorType(e.element));
  }

  bool isDomainClassWithSupportedPropertyTypes(Element element) {
    return isDomainClass(element) &&
        _createFields(element as ClassElement).isNotEmpty;
  }

  bool _isListSetMapIteratorType(InterfaceElement element) {
    String string = element.toString();
    return element.library.name == 'dart.core' &&
        (string.contains('class List<') ||
            string.contains('class Set<') ||
            string.contains('class Map<') ||
            string.contains('class Iterator<'));
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

  List<FieldMetadata> _createFields(ClassElement classElement) {
    final mapConverterAnnotation = findMapConverterAnnotation(classElement);

    var fieldMetaData = <FieldMetadata>[];
    var fields = _findAllPublicFields(classElement);
    var fieldAnnotations = _findFieldAnnotations(mapConverterAnnotation);
    for (var field in fields) {
      var fieldAnnotation = findFieldAnnotation(fieldAnnotations, field);
      var ignore = fieldAnnotation?.getField('ignore')?.toBoolValue() ?? false;
      if (!ignore) {
        var fieldPath = '${classElement.name}.${field.name}';
        try {
          var fieldType = field.type as InterfaceType;
          var valueExpressionFactory =
              ValueExpressionFactories().findFor(fieldType);
          var alias = fieldAnnotation?.getField('alias')?.toStringValue();
          var mapValueToObjectExpressionFunction =
              createMapValueToObjectExpressionFunction(
                  fieldAnnotation, valueExpressionFactory);
          var objectToMapValueExpressionFunction =
              createObjectToMapValueExpressionFunction(
                  fieldAnnotation, valueExpressionFactory);

          if (mapValueToObjectExpressionFunction == null &&
              objectToMapValueExpressionFunction == null) {
            log.log(
                Level.WARNING,
                'Property: $fieldPath '
                'has an unsupported type: $fieldType. '
                'Define a custom converter in the @MapConverter annotation.');
          } else {
            var fieldExpressionFactory = FieldMetadata(
              field,
              alias: alias,
              mapValueToObjectExpressionFunction:
                  mapValueToObjectExpressionFunction,
              objectToMapValueExpressionFunction:
                  objectToMapValueExpressionFunction,
            );
            fieldMetaData.add(fieldExpressionFactory);
          }
        } on Exception catch (e) {
          throw Exception('$fieldPath: $e');
        }
      }
    }
    return fieldMetaData;
  }

  DartObject? findFieldAnnotation(
      List<DartObject>? fieldAnnotations, FieldElement field) {
    return fieldAnnotations?.firstWhereOrNull((dartObject) =>
        (dartObject.getField('symbol')?.toSymbolValue()) == field.name);
  }

  MapValueToObjectExpressionFunction? createMapValueToObjectExpressionFunction(
      DartObject? fieldAnnotation,
      ValueExpressionFactory? valueExpressionFactory) {
    var mapValueToObjectCustomFunction =
        fieldAnnotation?.getField('fromPrimitiveConverter')?.toFunctionValue();
    if (mapValueToObjectCustomFunction == null &&
        valueExpressionFactory == null) {
      return null;
    }
    if (mapValueToObjectCustomFunction != null) {
      return createMapValueToObjectExpressionCustomFunction(
          functionName: mapValueToObjectCustomFunction.name!,
          functionLibraryUri: createRelativeLibraryUri(
              mapValueToObjectCustomFunction.library.uri.toString()));
    } else {
      return valueExpressionFactory!.mapValueToObjectFunction;
    }
  }

  ObjectToMapValueExpressionFunction? createObjectToMapValueExpressionFunction(
      DartObject? fieldAnnotation,
      ValueExpressionFactory? valueExpressionFactory) {
    var objectToMapValueExpressionFunction =
        fieldAnnotation?.getField('toPrimitiveConverter')?.toFunctionValue();
    if (objectToMapValueExpressionFunction == null &&
        valueExpressionFactory == null) {
      return null;
    }
    if (objectToMapValueExpressionFunction != null) {
      return createObjectToMapValueExpressionCustomFunction(
          functionName: objectToMapValueExpressionFunction.name!,
          functionLibraryUri: createRelativeLibraryUri(
              objectToMapValueExpressionFunction.library.uri.toString()));
    } else {
      return valueExpressionFactory!.objectToMapValueFunction;
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

  bool _hasMapConverterAnnotation(Element element) {
    for (var annotation in element.metadata.annotations) {
      var constantValue = annotation.computeConstantValue();
      if (constantValue?.type?.element?.name == "MapConverter") {
        return true;
      }
    }
    return false;
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

  // /// get property names to ignore from [MapConverter.properties] annotation
  // List<String> _findPropertyNamesToIgnore(ClassElement classElement) {
  //   var propertyNamesToIgnore = <String>[];
  //   for (var metadata in classElement.metadata) {
  //     var constantValue = metadata.computeConstantValue();
  //     if (constantValue?.type?.element?.name == "MapConverter") {
  //       var properties = constantValue?.getField("properties")?.toListValue();
  //       if (properties != null) {
  //         for (var property in properties) {
  //           var ignore = property.getField("ignore")?.toBoolValue();
  //           if (ignore == true) {
  //             var name = property.getField("name")?.toStringValue();
  //             if (name != null) {
  //               propertyNamesToIgnore.add(name);
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  //   return propertyNamesToIgnore;
  // }
}

MapValueToObjectExpressionFunction
    createMapValueToObjectExpressionCustomFunction({
  //FIXME: simpler names
  required String functionName,
  required String functionLibraryUri,
}) =>
        (
          MapConverterLibraryAssetIdFactory idFactory,
          code.Expression source,
          InterfaceType typeToConvert,
        ) =>
            code.Expression.callMethodOrFunction(
              functionName,
              libraryUri: functionLibraryUri,
              parameterValues:
                  code.ParameterValues([code.ParameterValue(source)]),
            );

ObjectToMapValueExpressionFunction
    createObjectToMapValueExpressionCustomFunction({
  //FIXME: simpler names
  required String functionName,
  required String functionLibraryUri,
}) =>
        (
          MapConverterLibraryAssetIdFactory idFactory,
          code.Expression source,
          InterfaceType typeToConvert,
        ) =>
            code.Expression.callMethodOrFunction(
              functionName,
              libraryUri: functionLibraryUri,
              parameterValues:
                  code.ParameterValues([code.ParameterValue(source)]),
            );

class BestConstructorFactory {
  /// returns the best constructor to be used to create an DomainObject when
  /// converting a [Map] to a DomainObject
  Constructor createFor(ClassElement classElement, List<FieldMetadata> fields) {
    var constructors = _usefulConstructors(classElement, fields);
    _orderByNumberOfPropertiesSet(constructors);
    return constructors.first;
  }

  /// constructor that sets most properties is put at the begin of the list
  void _orderByNumberOfPropertiesSet(List<Constructor> constructors) =>
      constructors.sort(
          (a, b) => b.fieldsBeingSet.length.compareTo(a.fieldsBeingSet.length));

  List<Constructor> _usefulConstructors(
    ClassElement classElement,
    List<FieldMetadata> fields,
  ) {
    var constructors = <Constructor>[];
    for (var constructorElement in classElement.constructors) {
      Constructor? constructor = _usefulConstructor(constructorElement, fields);
      if (constructor != null) {
        constructors.add(constructor);
      }
    }
    if (constructors.isEmpty) {
      constructors.add(Constructor.withoutParameters());
    }
    return constructors;
  }

  /// returns null if the constructor has parameters that can not be mapped to fields
  Constructor? _usefulConstructor(
      ConstructorElement constructorElement, List<FieldMetadata> fields) {
    var name = constructorElement.name;
    var requiredPositionalParameters = <FieldMetadata>[];
    var namedParameters = <FieldMetadata>[];
    var optionalParameters = <FieldMetadata>[];
    for (var parameter in constructorElement.formalParameters) {
      var field = _findProperty(parameter, fields);
      if (field == null && parameter.isRequired) {
        //do not know what to do with this constructor parameter
        return null;
      }
      if (field != null) {
        if (parameter.isRequiredPositional) {
          requiredPositionalParameters.add(field);
        } else if (parameter.isNamed) {
          namedParameters.add(field);
        } else if (parameter.isOptional) {
          optionalParameters.add(field);
        }
      }
    }
    return Constructor(
      name: name,
      requiredPositionalParameters: requiredPositionalParameters,
      namedParameters: namedParameters,
      optionalParameters: optionalParameters,
    );
  }

  FieldMetadata? _findProperty(
    FormalParameterElement parameter,
    List<FieldMetadata> fields,
  ) =>
      fields.firstWhereOrNull((field) => _isComparable(parameter, field));

  bool _isComparable(FormalParameterElement parameter, FieldMetadata field) =>
      field.element.name == parameter.name &&
      field.element.type.element != null &&
      parameter.type.element != null &&
      field.element.type.element!.name == parameter.type.element!.name &&
      field.element.type.element?.library?.uri ==
          parameter.type.element?.library?.uri;
}
