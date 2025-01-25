/// [Annotation] for classed that need [MapCoverter] functions
class MapConverter {
  final List<Property> properties;
  const MapConverter([this.properties = const []]);
}

class Property {
  final String name;
  final bool ignore;

  ///TODO final String? alias;
  /// A costum converter when the default converter wont do
  final PrimitiveConverter? converter;

  const Property(this.name, this.converter) : ignore = false;

  const Property.ignore(
    this.name,
  )   : ignore = true,
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
