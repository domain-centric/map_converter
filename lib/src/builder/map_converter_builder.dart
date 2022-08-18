import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:map_converter/src/builder/value_expression/value_expression_factory.dart';

final valueExpressionFactories = ValueExpressionFactories();

class MapConverterBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': ['dummy.dummy']
      };

  @override
  Future<FutureOr<void>> build(BuildStep buildStep) async {
    try {
      var libraryElement = await buildStep.inputLibrary;
      var topElements = libraryElement.topLevelElements;
      for (var topElement in topElements) {
        if (topElement is ClassElement &&
            topElement.isPublic &&
            !topElement.isAbstract &&
            topElement is! EnumElement &&
            topElement.thisType.allSupertypes
                .none((e) => _isListSetMapIteratorType(e.element2))) {
          //TODO configure which classes to exclude, e.g. yaml file with regexp to exclude the paths to dart files and class names.

          var classElement = topElement;
          var propertyMap = _propertyMap(classElement);
          if (propertyMap.isNotEmpty) {
            log.log(Level.INFO, '  $classElement');
            for (var property in propertyMap.keys) {
              var fieldType = property.type as InterfaceType;
              var valueExpressionFactory = propertyMap[property];
              var nullable =
                  fieldType.nullabilitySuffix == NullabilitySuffix.question;

              var fieldType2 = (property.type as InterfaceType).element2;
              log.log(Level.INFO,
                  '    ${property.name} $fieldType2 $nullable ${fieldType2.librarySource} ${valueExpressionFactory?.runtimeType}');
            }
          }
        }
      }
    } catch (e, stackTrace) {
      log.log(
          Level.SEVERE,
          'Error processing: ${buildStep.inputId.path}. Error: \n$e',
          stackTrace);
    }
  }

  /// Gets all fields that represent properties from the [InterfaceElement]
  /// including those from super classes, mixins and interfaces
  List<FieldElement> _findAllProperties(InterfaceElement interfaceElement) {
    Map<String, FieldElement> fields = {};
    for (var fieldElement in interfaceElement.fields) {
      if (_isPropertyField(fieldElement)) {
        fields[fieldElement.name] = fieldElement;
      }
    }
    for (var superType in interfaceElement.allSupertypes) {
      var superTypeFields = _findAllProperties(superType.element2);
      for (var superTypeField in superTypeFields) {
        fields[superTypeField.name] = superTypeField;
      }
    }
    return fields.values.toList();
  }

  /// creates a [MAP] with [FieldElement] and [ValueExpressionFactory] for
  /// any property in a [ClassElement]
  /// if there is a matching [ValueExpressionFactory].
  Map<FieldElement, ValueExpressionFactory> _propertyMap(
      InterfaceElement classElement) {
    var propertyMap = <FieldElement, ValueExpressionFactory>{};
    var properties = _findAllProperties(classElement);
    for (var property in properties) {
      var propertyType = property.type as InterfaceType;
      var valueExpressionFactory = valueExpressionFactories.firstWhereOrNull(
          (valueExpressionFactory) =>
              valueExpressionFactory.canConvert(propertyType));
      if (valueExpressionFactory == null) {
        log.log(Level.WARNING, 'Could not find a $ValueExpressionFactory '
                'for type: $propertyType '
                'in: ${classElement.name}.${property.name}');
      } else {
        propertyMap[property] = valueExpressionFactory;
      }
    }
    return propertyMap;
  }

  bool _isPropertyField(FieldElement fieldElement) =>
      !fieldElement.isAbstract &&
      !fieldElement.isStatic &&
      !fieldElement.isConst &&
      (fieldElement.setter != null || _isSetInConstructor(fieldElement)) &&
      fieldElement.type is InterfaceType;

  bool _isSetInConstructor(FieldElement fieldElement) => false;

  _isListSetMapIteratorType(InterfaceElement element) {
    String string = element.toString();
    // print("-- $string");
    return element.library.name == 'dart.core' &&
        (string.contains('class List<') ||
            string.contains('class Set<') ||
            string.contains('class Map<') ||
            string.contains('class Iterator<'));
  }
}
