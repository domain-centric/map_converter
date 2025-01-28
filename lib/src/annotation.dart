import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

/// [Annotation] for classed that need [MapCoverter] functions
class MapConverter {
  final List<Property> properties;
  const MapConverter([this.properties = const []]);
}

class Property {
  final String name;
  final bool ignore;
  final String? alias;

  /// A costum converter when the default converter wont do
  final PrimitiveConverter? converter;

  const Property(
    this.name, {
    this.alias,
    this.converter,
    this.ignore = false,
  });

  const Property.ignore(
    this.name,
  )   : ignore = true,
        alias = null,
        converter = null;
}

abstract class PrimitiveConverter<SOURCE, PRIMITIVE> {
  const PrimitiveConverter();

  PRIMITIVE toPrimitive(SOURCE value);

  SOURCE fromPrimitive(PRIMITIVE value);
}

MapConverter? createFromClassElement(ClassElement domainClassElement) {
  final annotation = domainClassElement.metadata.firstWhereOrNull(
    (element) =>
        element.computeConstantValue()?.type?.getDisplayString() ==
        'MapConverter',
  );
  if (annotation == null) {
    return null;
  }

  final properties = annotation
      .computeConstantValue()
      ?.getField('properties')
      ?.toListValue()
      ?.map((element) {
    final String name = element.getField('name')!.toStringValue() ?? '';
    final bool ignore = element.getField('ignore')!.toBoolValue() ?? false;
    final String? alias = element.getField('alias')?.toStringValue();
    final converterType = _converterType(element);

    return PropertyWithConverterType(
      name,
      alias: alias,
      ignore: ignore,
      converterType: converterType,
    );
  }).toList();
  if (properties == null) {
    return MapConverter([]);
  }
  return MapConverter(properties);
}

DartType? _converterType(DartObject element) {
  final DartObject? converterObject = element.getField('converter');
  if (converterObject == null || converterObject.isNull) {
    return null;
  } else {
    return converterObject.type;
  }
}

class PropertyWithConverterType extends Property {
  final DartType? converterType;

  const PropertyWithConverterType(
    super.name, {
    super.alias,
    super.ignore = false,
    super.converter,
    this.converterType,
  });
}
