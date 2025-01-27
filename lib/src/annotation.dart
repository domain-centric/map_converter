import 'package:analyzer/dart/element/element.dart';

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
  }) ;

  const Property.ignore(
    this.name,
  )   : ignore = true,
        alias = null,
        converter = null;
}

abstract class PrimitiveConverter<SOURCE, PRIMITIVE> {
  const PrimitiveConverter();

  PRIMITIVE toPrimitive(SOURCE value) {
    throw UnimplementedError();
  }

  SOURCE fromPrimitive(PRIMITIVE value) {
    throw UnimplementedError();
  }
}

MapConverter createFromClassElement(ClassElement domainClassElement) {
  final annotation = domainClassElement.metadata.firstWhere(
    (element) => element.computeConstantValue()?.type?.getDisplayString() == 'MapConverter',
    orElse: () => throw Exception('No MapConverter annotation found'),
  );

  final properties = annotation.computeConstantValue()?.getField('properties')?.toListValue()?.map((element) {
    final String name = element.getField('name')!.toStringValue() ?? '';
    final bool ignore = element.getField('ignore')!.toBoolValue() ?? false;
    final String? alias = element.getField('alias')?.toStringValue();
    final Element? converter = element.getField('converter')?.toTypeValue()?.element;

    return Property(
      name,
      alias: alias,
      ignore: ignore,
      //TODO converter: converter,
    );
  }).toList();
  if (properties == null) {
      return MapConverter([]);
  }
  return MapConverter(properties);
}
