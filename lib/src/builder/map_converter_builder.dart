import 'dart:async';

import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:map_converter/src/builder/value_expression/value_expression_factory.dart';

final valueExpressionFactories=ValueExpressionFactories();

class MapConverterBuilder implements Builder {

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': ['dummy.dummy']
      };

  @override
  Future<FutureOr<void>> build(BuildStep buildStep) async {
    try {
      var libraryElement=await buildStep.inputLibrary;
      log.log(Level.INFO, '$libraryElement');
      var topElements=libraryElement.topLevelElements;
      for (var topElement in topElements) {
        if (topElement is ClassElement && topElement.isPublic && !topElement.isAbstract && topElement is! EnumElement) {
          //TODO check if element does not implement a MAP or a LIST or a SET
          //TODO field from mixins and super classes (classElement=topElement.augmented???)
          //TODO configure which classes to exclude, e.g. yaml file with regexp to exclude the paths to dart files and class names.

          log.log(Level.INFO, '  $topElement');
          var classElement=topElement;
          var fieldElements=classElement.fields;
          for (var fieldElement in fieldElements) {
            if (!fieldElement.isAbstract && !fieldElement.isStatic && !fieldElement.isConst && (fieldElement.setter!=null || _isSetInConstructor(fieldElement))) {
              //TODO ignore fields that do not be set:
              var fieldType=fieldElement.type as InterfaceType;
              var valueExpressionFactory=valueExpressionFactories.firstWhereOrNull((valueExpressionFactory) => valueExpressionFactory.canConvert(fieldType));
              var nullable=fieldType.nullabilitySuffix==NullabilitySuffix.question;

              var fieldType2=(fieldElement.type as InterfaceType).element2;
              log.log(Level.INFO, '    ${fieldElement.name} $fieldType2 $nullable ${fieldType2.librarySource} ${valueExpressionFactory?.runtimeType}');
              //log.log(Level.INFO,'   ${fieldElement.name} $fieldType2 ${fieldType.getDisplayString(withNullability: false)} ${fieldType2.library}');

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

  bool _isSetInConstructor(FieldElement fieldElement) => false;//TODO
}
