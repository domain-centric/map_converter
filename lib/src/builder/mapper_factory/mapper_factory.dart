import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/mapper_factory/domain_class_mapper_factory.dart';
import 'package:map_converter/src/builder/mapper_factory/polymorphism_mapper_factory.dart';

abstract class MapperFactory {
  /// returns true if the Analyzer element is supported vy the MapperFactory implementation
  bool supports(Element element);

  /// creates a Mapper class code
  /// Only call this method if [supports] returns true
  code.Class create(
      Element element, MapConverterLibraryAssetIdFactory idFactory);
}

class MapperFactories extends DelegatingList<MapperFactory>
    implements MapperFactory {
  MapperFactories()
      : super([
          DomainClassMapperFactory(),
          PolymorphismMapperFactory(),
        ]);

  @override
  code.Class create(
          Element element, MapConverterLibraryAssetIdFactory idFactory) =>
      firstWhere((mapperFactory) => mapperFactory.supports(element))
          .create(element, idFactory);

  @override
  bool supports(Element element) =>
      any((mapperFactory) => mapperFactory.supports(element));
}

bool isListSetMapIteratorType(InterfaceElement element) {
  String string = element.toString();
  return element.library.name == 'dart.core' &&
      (string.contains('class List<') ||
          string.contains('class Set<') ||
          string.contains('class Map<') ||
          string.contains('class Iterator<'));
}

  /// discriminator key for a class with a @MapConverter annotation.
  /// If the class does not have a discriminator key,
  /// it will look for a superclass with a @MapConverter annotation
  /// and return its discriminator key (or its default value '_type').
  /// If no superclass has a @MapConverter annotation, it will return null.
  String? findDiscriminatorKey(ClassElement classElement) {
    var annotation = findMapConverterAnnotation(classElement);
    var discriminatorKey =
        annotation?.getField('discriminatorKey')?.toStringValue();
    if (discriminatorKey != null && discriminatorKey.isNotEmpty) {
      return discriminatorKey;
    }

    var superClass = findSuperClassWithMapConverterAnnotation(classElement);
    if (superClass == null || superClass is! ClassElement) {
      return null;
    }
    var superClassAnnotation = findMapConverterAnnotation(superClass);
    var superClassDiscriminatorKey =
        superClassAnnotation?.getField('discriminatorKey')?.toStringValue();
    if (superClassDiscriminatorKey != null &&
        superClassDiscriminatorKey.isNotEmpty) {
      return superClassDiscriminatorKey;
    } else {
      return '_type';
    }
  }

  InterfaceElement? findSuperClassWithMapConverterAnnotation(
      ClassElement classElement) {

    var superClass = classElement.supertype?.element;
    while (superClass != null) {
      if (superClass is! ClassElement) {
        return null;
      }
      var annotation = findMapConverterAnnotation(superClass);
      if (annotation != null) {
        return superClass;
      }
      superClass = superClass.supertype?.element;
    }
    return null;
  }
