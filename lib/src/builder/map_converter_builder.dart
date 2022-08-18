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
      log.log(Level.INFO, '$libraryElement');
      var topElements = libraryElement.topLevelElements;
      for (var topElement in topElements) {
        if (topElement is ClassElement &&
            topElement.isPublic &&
            !topElement.isAbstract &&
            topElement is! EnumElement) {
          //TODO check if element does not implement a MAP or a LIST or a SET
          //TODO configure which classes to exclude, e.g. yaml file with regexp to exclude the paths to dart files and class names.

          log.log(Level.INFO, '  $topElement');
          var classElement = topElement;
          var propertyFields = _findAllPropertyFields(classElement);
          for (var propertyField in propertyFields) {
            var fieldType = propertyField.type as InterfaceType;
            var valueExpressionFactory = valueExpressionFactories
                .firstWhereOrNull((valueExpressionFactory) =>
                    valueExpressionFactory.canConvert(fieldType));
            var nullable =
                fieldType.nullabilitySuffix == NullabilitySuffix.question;

            var fieldType2 = (propertyField.type as InterfaceType).element2;
            log.log(Level.INFO,
                '    ${propertyField.name} $fieldType2 $nullable ${fieldType2.librarySource} ${valueExpressionFactory?.runtimeType}');

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
  List<FieldElement> _findAllPropertyFields(InterfaceElement interfaceElement) {
    Map<String, FieldElement> fields = {};
    for (var fieldElement in interfaceElement.fields) {
      if (_isPropertyField(fieldElement)) {
        fields[fieldElement.name]=fieldElement;
      }
    }
    for (var superType in interfaceElement.allSupertypes) {
      var superTypeFields = _findAllPropertyFields(superType.element2);
      for (var superTypeField in superTypeFields) {
        fields[superTypeField.name]=superTypeField;
      }
    }
    return fields.values.toList();
  }

  bool _isPropertyField(FieldElement fieldElement) =>
      !fieldElement.isAbstract &&
      !fieldElement.isStatic &&
      !fieldElement.isConst &&
      (fieldElement.setter != null || _isSetInConstructor(fieldElement)) &&
      fieldElement.type is InterfaceType;

  bool _isSetInConstructor(FieldElement fieldElement) => false;
}
