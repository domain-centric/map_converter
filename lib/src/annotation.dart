import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';

/// [Annotation] to add to your class to:
/// * define what functions need to be generated from a class
/// * how these functions should work
class MapConverter {
  // defines what to generate. See [GenerateOptions]
  final int generateOptions;

  /// Specify additional subclasses of this class for polymorphism.
  final Iterable<Type> subClasses;

  /// Property key used for type discriminators.
  ///
  /// For polymorphic classes this will be used for identifying the
  /// correct subtype when decoding an object.
  final String? discriminatorKey;

  /// Custom value for the discriminator property.
  /// If not set this defaults to the class name.
  final dynamic discriminatorValue;

  /// Specify additional subclasses of this class for polymorphism.
  final Iterable<Type>? includeSubClasses;

  final List<Field> fields;

  const MapConverter(
      {this.generateOptions = GenerateOptions.all,
      this.subClasses = const <Type>[],
      this.discriminatorKey,
      this.discriminatorValue,
      this.includeSubClasses,
      this.fields = const <Field>[]});
}

class GenerateOptions {
  /// Indicates to generate a toMap method.
  static const int toMap = 0x1;

  /// Indicates to to generate a fromMap method.
  static const int fromMap = 0x2;

  /// Indicates to to generate a schema method.
  static const int schema = 0x4;

  /// Indicates to generate all available methods.
  static const int all = toMap + fromMap + schema;
}

typedef Converter<RETURN_VALUE, SOURCE_VALUE> = RETURN_VALUE Function(
    SOURCE_VALUE);

class Field<OBJECT_TYPE, PRIMITIVE_TYPE> {
  final Symbol symbol;
  final bool ignore;
  final String? alias;

  /// A custom converter to convert a field value to a map property value
  final PRIMITIVE_TYPE Function(OBJECT_TYPE)? toPrimitiveConverter;

  /// A custom converter to convert a map property value to a field value
  final OBJECT_TYPE Function(PRIMITIVE_TYPE)? fromPrimitiveConverter;

  const Field(
    this.symbol, {
    this.alias,
    this.toPrimitiveConverter,
    this.fromPrimitiveConverter,
    this.ignore = false,
  });

  const Field.ignore(
    this.symbol,
  )   : ignore = true,
        alias = null,
        toPrimitiveConverter = null,
        fromPrimitiveConverter = null;

  String get name {
    final text = toString(); // Symbol("myProperty")
    return text.substring(8, text.length - 2);
  }
}

DartObject? findMapConverterAnnotation(ClassElement domainClassElement) =>
    domainClassElement.metadata.annotations
        .firstWhereOrNull(
          (element) =>
              // element.computeConstantValue()?.type?.getDisplayString() ==
              // 'MapConverter',
              element.computeConstantValue()?.type?.element?.name ==
              'MapConverter',
        )
        ?.computeConstantValue();
