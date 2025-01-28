import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:logging/logging.dart';
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:recase/recase.dart';

final valueExpressionFactories = ValueExpressionFactories.all();

class MapConverterBuilder implements Builder {
  final BuilderOptions builderOptions;
  MapConverterBuilder(this.builderOptions) {
    print("config: ${builderOptions.config}");
  }

  /// Gets the input parameter of the options section in the build.yaml file.
  /// The input tells the [MapConverterBuilder] which files to process.
  /// See keys of [buildExtensions]
  ///
  /// Example of a build.yaml:
  /// targets:
  ///   $default:
  ///     builders:
  ///       map_converter|map_converter_builder:
  ///         enabled: True
  ///         options:
  ///           input: ^lib/domain/{{}}.dart
  ///           output: lib/domain/{{}}.data.converter.map.dart
  String get input => (builderOptions.config['input'] ?? '').trim();

  /// Gets the output parameter of the options section in the build.yaml file.
  /// The output tells the [MapConverterBuilder] where to store the results.
  /// See value of [buildExtensions]
  ///
  /// Example of a build.yaml:
  /// targets:
  ///   $default:
  ///     builders:
  ///       map_converter|map_converter_builder:
  ///         enabled: True
  ///         options:
  ///           input: ^lib/domain/{{}}.dart
  ///           output: lib/domain/{{}}.data.converter.map.dart
  String get output => (builderOptions.config['output'] ?? '').trim();

  @override
  Map<String, List<String>> get buildExtensions {
    if (input.isEmpty) {
      log.log(
          Level.SEVERE,
          'input option in build.yaml file is not defined. '
          'See documentation on: https://pub.dev/packages/map_converter');
    }
    if (output.isEmpty) {
      log.log(
          Level.SEVERE,
          'output option in build.yaml file is not defined. '
          'See documentation on: https://pub.dev/packages/map_converter');
    }
    return {
      input: [output]
    };
  }
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
        var dartCode = code.CodeFormatter().format(library);
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
    var inputLibraryUri = domainObjectType.element.librarySource.uri;
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
          .add(ObjectToMapFunctionFactory().create(domainClass, idFactory));
      functions
          .add(MapToObjectFunctionFactory().create(domainClass, idFactory));
    }
    return functions;
  }

  List<code.DocComment> _createDocComments(LibraryElement libraryElement) => [
        code.DocComment.fromList([
          'Do not make changes to this file!',
          'This file is generated by: $MapConverterBuilder',
          'From: ${libraryElement.librarySource.uri}',
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
    for (var property in domainClass.properties) {
      var propertyNameExpression =
          code.Expression.ofString(property.alias ?? property.name);
      var expressionFactory = property.valueExpressionFactory;
      var nullable = property.fieldElement.type.nullabilitySuffix ==
          NullabilitySuffix.question;
      var propertyType = property.fieldElement.type as InterfaceType;
      var instanceVariableName = domainClass.element.name.camelCase;
      var source = code.Expression.ofVariable(instanceVariableName)
          .getProperty(property.fieldElement.name);
      var propertyValue = expressionFactory.objectToMapValue(
        idFactory,
        property,
        source,
        propertyType,
        nullable: nullable,
      );
      map[propertyNameExpression] = propertyValue;
    }
    return code.Expression.ofMap(map);
  }

  code.Parameters _createParameters(DomainClass domainClass) =>
      code.Parameters([
        code.Parameter.required(
          domainClass.element.name.camelCase,
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
    for (var property in domainClass.noneConstructorProperties) {
      var propertyName = property.alias ?? property.name;
      var propertyValue = propertyValueExpression(
        property,
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
      '${domainClass.element.name.camelCase}Map';

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
      parameterValues.add(code.ParameterValue.named(
          parameter.fieldElement.name, valueExpression));
    }
    return code.ParameterValues(parameterValues);
  }
}

createDomainType(DomainClass domainClass) => code.Type(
      domainClass.element.name,
      libraryUri: createLibraryUri(domainClass.element),
    );

code.Expression propertyValueExpression(
    PropertyWithValueExpressionFactory property,
    MapConverterLibraryAssetIdFactory idFactory,
    String mapVariableName) {
  var propertyName = property.alias ?? property.name;
  var propertyType = property.fieldElement.type as InterfaceType;
  var nullable = property.fieldElement.type.nullabilitySuffix ==
      NullabilitySuffix.question;
  var source = code.Expression.ofVariable(mapVariableName)
      .index(code.Expression.ofString(propertyName));
  var valueExpression = property.valueExpressionFactory.mapValueToObject(
    idFactory,
    property,
    source,
    propertyType,
    nullable: nullable,
  );
  return valueExpression;
}

/// Contains information on a [DomainClass] to generate [MapConverter]s
class DomainClass {
  final ClassElement element;
  final Constructor bestConstructor;
  final List<PropertyWithValueExpressionFactory> properties;
  late List<PropertyWithValueExpressionFactory> noneConstructorProperties;

  DomainClass(
    this.element,
    this.bestConstructor,
    this.properties,
  ) {
    noneConstructorProperties = properties
        .whereNot(
            (property) => bestConstructor.propertiesBeingSet.contains(property))
        .toList();
  }
}

class Constructor {
  late String? name;
  final List<PropertyWithValueExpressionFactory> requiredPositionalParameters;
  final List<PropertyWithValueExpressionFactory> namedParameters;
  final List<PropertyWithValueExpressionFactory> optionalParameters;
  late Set<PropertyWithValueExpressionFactory> propertiesBeingSet;

  Constructor({
    String? name,
    required this.requiredPositionalParameters,
    required this.namedParameters,
    required this.optionalParameters,
  }) {
    this.name = (name == null || name.isEmpty) ? null : name;
    propertiesBeingSet = {};
    propertiesBeingSet.addAll(requiredPositionalParameters);
    propertiesBeingSet.addAll(namedParameters);
    propertiesBeingSet.addAll(optionalParameters);
  }

  Constructor.basic()
      : name = null,
        requiredPositionalParameters = [],
        namedParameters = [],
        optionalParameters = [],
        propertiesBeingSet = {};
}

class PropertyWithBuildInfo extends PropertyWithConverterType {
  final ClassElement classElement;
  final FieldElement fieldElement;

  PropertyWithBuildInfo(
    super.name, {
    super.alias,
    super.ignore,
    super.converter,
    super.converterType,
    required this.classElement,
    required this.fieldElement,
  });
}

class PropertyWithValueExpressionFactory extends PropertyWithBuildInfo {
  final ValueExpressionFactory valueExpressionFactory;

  PropertyWithValueExpressionFactory(
    super.name, {
    required super.alias,
    required super.ignore,
    super.converter,
    required super.converterType,
    required super.classElement,
    required super.fieldElement,
    required this.valueExpressionFactory,
  });
}

class DomainClassFactory {
  List<DomainClass> create(LibraryElement libraryElement) {
    var domainClasses = <DomainClass>[];
    var topElements = libraryElement.topLevelElements;
    for (var topElement in topElements) {
      if (_isDomainClass(topElement)) {
        var classElement = topElement as ClassElement;
        var properties = _createProperties(classElement);
        if (properties.isNotEmpty) {
          var bestConstructor =
              BestConstructorFactory().createFor(classElement, properties);
          var domainClass =
              DomainClass(classElement, bestConstructor, properties);
          domainClasses.add(domainClass);
        }
      }
    }
    return domainClasses;
  }

  bool _isDomainClass(Element element) {
    return _hasMapConverterAnnotation(element) &&
        element is ClassElement &&
        element.isPublic &&
        !element.isAbstract &&
        element is! EnumElement &&
        element.thisType.allSupertypes
            .none((e) => _isListSetMapIteratorType(e.element));
  }

  bool isDomainClassWithSupportedPropertyTypes(Element element) {
    return _isDomainClass(element) &&
        _createProperties(element as ClassElement).isNotEmpty;
  }

  _isListSetMapIteratorType(InterfaceElement element) {
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
    for (var fieldElement in interfaceElement.fields) {
      if (_isPublicPropertyField(fieldElement)) {
        fields[fieldElement.name] = fieldElement;
      }
    }
    for (var superType in interfaceElement.allSupertypes) {
      var superTypeFields = _findAllPublicFields(superType.element);
      for (var superTypeField in superTypeFields) {
        fields[superTypeField.name] = superTypeField;
      }
    }
    return fields.values.toList();
  }

  /// creates a [MAP] with [FieldElement] and [ValueExpressionFactory] for
  /// any property in a [ClassElement]
  /// if there is a matching [ValueExpressionFactory].
  List<PropertyWithValueExpressionFactory> _createProperties(
      ClassElement classElement) {
    var mapConverterAnnotation = createFromClassElement(classElement);

    var properties = <PropertyWithValueExpressionFactory>[];
    var fields = _findAllPublicFields(classElement);
    for (var field in fields) {
      var propertyAnnotation = mapConverterAnnotation!.properties
          .firstWhereOrNull((element) => element.name == field.name);
      if (propertyAnnotation?.ignore != true) {
        var propertyPath = '${classElement.name}.${field.name}';
        try {
          var propertyType = field.type as InterfaceType;
          var valueExpressionFactory = valueExpressionFactories.findFor(
              propertyAnnotation, classElement, propertyType);
          if (valueExpressionFactory == null) {
            log.log(
                Level.WARNING,
                'Could not find a $ValueExpressionFactory '
                'for type: $propertyType '
                'used in property: $propertyPath');
          } else {
            var property = PropertyWithValueExpressionFactory(field.name,
                alias: propertyAnnotation?.alias,
                ignore: false,
                converterType: propertyAnnotation == null
                    ? null
                    : (propertyAnnotation as PropertyWithConverterType)
                        .converterType,
                classElement: classElement,
                fieldElement: field,
                valueExpressionFactory: valueExpressionFactory);
            properties.add(property);
          }
        } on Exception catch (e) {
          throw Exception('$propertyPath: $e');
        }
      }
    }
    return properties;
  }

  // Iterable<FieldElement> _findFieldsToProcess(ClassElement classElement) {
  //   var publicFields = _findAllPublicFields(classElement);
  //   var propertyNamesToIgnore = _findPropertyNamesToIgnore(classElement);
  //   var fieldsToProcess = publicFields
  //       .where((field) => !propertyNamesToIgnore.contains(field.name));
  //   return fieldsToProcess;
  // }

  bool _isPublicPropertyField(FieldElement fieldElement) =>
      fieldElement.isPublic &&
      !fieldElement.isAbstract &&
      !fieldElement.isStatic &&
      !fieldElement.isConst &&
      (fieldElement.setter != null || _isSetInConstructor(fieldElement)) &&
      fieldElement.type is InterfaceType;

  bool _isSetInConstructor(FieldElement fieldElement) => fieldElement.isFinal;

  bool _hasMapConverterAnnotation(Element element) {
    for (var metadata in element.metadata) {
      var constantValue = metadata.computeConstantValue();
      if (constantValue?.type?.element?.name == "MapConverter") {
        return true;
      }
    }
    return false;
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

class BestConstructorFactory {
  /// returns the best constructor to be used to create an DomainObject when
  /// converting a [Map] to a DomainObject
  Constructor createFor(ClassElement classElement,
      List<PropertyWithValueExpressionFactory> properties) {
    var constructors = _usefulConstructors(classElement, properties);
    _orderByNumberOfPropertiesSet(constructors);
    return constructors.first;
  }

  /// constructor that sets most properties is put at the begin of the list
  void _orderByNumberOfPropertiesSet(List<Constructor> constructors) =>
      constructors.sort((a, b) =>
          b.propertiesBeingSet.length.compareTo(a.propertiesBeingSet.length));

  List<Constructor> _usefulConstructors(
    ClassElement classElement,
    List<PropertyWithValueExpressionFactory> properties,
  ) {
    var constructors = <Constructor>[];
    for (var constructorElement in classElement.constructors) {
      Constructor? constructor =
          _usefulConstructor(constructorElement, properties);
      if (constructor != null) {
        constructors.add(constructor);
      }
    }
    if (constructors.isEmpty) {
      constructors.add(Constructor.basic());
    }
    return constructors;
  }

  /// returns null if the constructor has parameters that are not understood
  Constructor? _usefulConstructor(ConstructorElement constructorElement,
      List<PropertyWithValueExpressionFactory> properties) {
    var name = constructorElement.name;
    var requiredPositionalParameters = <PropertyWithValueExpressionFactory>[];
    var namedParameters = <PropertyWithValueExpressionFactory>[];
    var optionalParameters = <PropertyWithValueExpressionFactory>[];
    for (var parameter in constructorElement.parameters) {
      var property = _findProperty(parameter, properties);
      if (property == null && parameter.isRequired) {
        //do not know what to do with this constructor parameter
        return null;
      }
      if (property != null) {
        if (parameter.isRequiredPositional) {
          requiredPositionalParameters.add(property);
        } else if (parameter.isNamed) {
          namedParameters.add(property);
        } else if (parameter.isOptional) {
          optionalParameters.add(property);
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

  PropertyWithValueExpressionFactory? _findProperty(
    ParameterElement parameter,
    List<PropertyWithValueExpressionFactory> properties,
  ) =>
      properties
          .firstWhereOrNull((property) => _isComparable(parameter, property));

  bool _isComparable(
          ParameterElement parameter, PropertyWithBuildInfo property) =>
      property.name == parameter.name &&
      property.fieldElement.type.element != null &&
      parameter.type.element != null &&
      property.fieldElement.type.element!.name ==
          parameter.type.element!.name &&
      property.fieldElement.type.element!.librarySource.toString() ==
          parameter.type.element!.librarySource.toString();
}
