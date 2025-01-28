import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/big_int.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/bool.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/custom_converter.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/date_time.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/domain_object.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/double.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/duration.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/enum.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/int.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/num.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/string.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/uri.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/list.dart';

/// Creates a Dart code expressions for a generated MapConverter functions
abstract class ValueExpressionFactory {
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  );

  /// Creates a Dart code expressions for a generated MapConverter
  /// to convert a [PrimativeTypes] to an object
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,

    /// [source]: An expression of the source data, e.g.:
    /// * personMap['propertyName'] (a [PrimativeTypes] within a [Map])
    /// * e (for an element in a collection)
    /// * k (for a key value in a [Map])
    /// * v (for a value in a [Map])
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  });

  /// Creates a Dart code expressions for a generated MapConverter
  /// to convert a [source] object to a [PrimativeTypes]
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,

    /// [source]: An expression of the source data, e.g.:
    /// * person.name (a field or property value of an object)
    /// * e (for an element in a collection)
    /// * k (for a key value in a [Map])
    /// * v (for a value in a [Map])
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  });
}

/// By convention, a [PrimativeMap] map:
/// * Has key values that are often camelCased [String]
/// * Has a limited set of values types, see [PrimativeTypes]
class PrimativeMap {
  //only used as documentation
}

/// By convention, a [PrimativeTypes] should only be one of the following:
/// * null
/// * [bool]
/// * [int]
/// * [num]
/// * [String]
/// * [List] with only of the types above
/// * [Map] see [PrimativeMap]
class PrimativeTypes {
  //only used as documentation
}

/// Supported basic types from dart core library
class ValueExpressionFactories extends DelegatingList<ValueExpressionFactory> {
  ValueExpressionFactories.basic()
      : super([
          BoolExpressionFactory(),
          NumExpressionFactory(),
          IntExpressionFactory(),
          DoubleExpressionFactory(),
          StringExpressionFactory(),
          UriExpressionFactory(),
          BigIntExpressionFactory(),
          DateTimeExpressionFactory(),
          DurationExpressionFactory(),
          EnumExpressionFactory(),
          DomainObjectExpressionFactory(),
        ]);

  ValueExpressionFactories.collection()
      : super([
          ListExpressionFactory(),
        ]);

  ValueExpressionFactories.all()
      : super([
          /// [CustomConverterExpressionFactory] must be first in the list
          /// so that it overrides other factories
          CustomConverterExpressionFactory(),
          ...ValueExpressionFactories.basic(),
          ...ValueExpressionFactories.collection(),
        ]);

  ValueExpressionFactory? findFor(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      firstWhereOrNull((valueExpressionFactory) => valueExpressionFactory
          .canConvert(propertyAnnotation, classElement, typeToConvert));

  bool supports(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      findFor(propertyAnnotation, classElement, typeToConvert) != null;
}


code.Type createType(Element element, bool nullable) => code.Type(
      element.displayName,
      libraryUri: createLibraryUri(element),
      nullable: nullable,
    );

String? createLibraryUri(Element element) {
  String? libraryUri = element.librarySource!.uri.toString();
  if (libraryUri == 'dart:core') {
    return null;
  }
  if (libraryUri.startsWith('package:')) {
    return libraryUri;
  }
  return createRelativeLibraryUri(libraryUri);
}

String createRelativeLibraryUri(String libraryUri) {
  var numberOfSlashes = '/'.allMatches(libraryUri).length;
  var foldersUpToRoot = numberOfSlashes - 1;
  int indexFirstSlash = libraryUri.indexOf('/');
  if (indexFirstSlash == -1) {
    return libraryUri;
  }
  return '${'../' * foldersUpToRoot}${libraryUri.substring(indexFirstSlash + 1)}';
}

code.Expression wrapWithIfNullWhenNullable(
    bool nullable, code.Expression source, code.Expression result) {
  if (nullable) {
    return source
        .equalTo(code.Expression.ofNull())
        .conditional(code.Expression.ofNull(), result);
  } else {
    return result;
  }
}