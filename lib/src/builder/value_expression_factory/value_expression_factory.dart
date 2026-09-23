import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/big_int.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/bool.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/date_time.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/domain_object.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/double.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/duration.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/enum.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/int.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/iterable.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/map.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/num.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/set.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/string.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/uri.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/list.dart';

// class Query {
//   final InterfaceType typeToConvert;
//   final Property? propertyAnnotation;

//   Query(this.typeToConvert, [this.propertyAnnotation]);

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is Query &&
//         other.typeToConvert == typeToConvert &&
//         other.propertyAnnotation == propertyAnnotation;
//   }

//   @override
//   int get hashCode => typeToConvert.hashCode ^ propertyAnnotation.hashCode;

//   @override
//   String toString() {
//     return 'Query(typeToConvert: $typeToConvert, propertyAnnotation: $propertyAnnotation)';
//   }
// }

abstract class SupportResult {
  static SupportResult of(bool supported) {
    if (supported) {
      return Supported();
    } else {
      return NotSupported();
    }
  }
}

/// Returned if a [ValueExpressionFactory] can process a given type and or property annotation
class Supported implements SupportResult {
  const Supported();
}

class SupportedIfTypesAreSupported implements SupportResult {
  /// Types that need to be supported
  final Set<InterfaceType> typesThatMustBeSupported;

  const SupportedIfTypesAreSupported(this.typesThatMustBeSupported);
}

/// Returned if a [ValueExpressionFactory] not process a given type and or property annotation
class NotSupported implements SupportResult {
  const NotSupported();
}

/// Creates a Dart code expressions for a generated MapConverter functions
abstract class ValueExpressionFactory {
  SupportResult supports(
    InterfaceType typeToConvert,
  );

  
  MapValueToObjectExpressionFunction get mapValueToObjectFunction;

  ObjectToMapValueExpressionFunction get objectToMapValueFunction;
}

/// By convention, a [PrimitiveMap] map:
/// * Has key values that are often camelCased [String]
/// * Has a limited set of values types, see [PrimitiveType]
class PrimitiveMap {
  //only used as documentation
}

/// By convention, a [PrimitiveType] should only be one of the following:
/// * null
/// * [bool]
/// * [int]
/// * [num]
/// * [String]
/// * [List] with only of the types above
/// * [Map] see [PrimitiveMap]
class PrimitiveType {
  //only used as documentation
}

/// Supported basic types from dart core library
class ValueExpressionFactories extends DelegatingList<ValueExpressionFactory> {
  static final _coreValueExpressionFactories = [
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
  ];

  static final _collectionValueExpressionFactories = [
    ListExpressionFactory(),
    SetExpressionFactory(),
    IterableExpressionFactory(),
    MapExpressionFactory()
  ];

  static final ValueExpressionFactories _instance =
      ValueExpressionFactories._internal();

  factory ValueExpressionFactories() {
    return _instance;
  }

  ValueExpressionFactories._internal()
      : super([
          ..._coreValueExpressionFactories,
          ..._collectionValueExpressionFactories
        ]);

  final Map<InterfaceType, ValueExpressionFactory> _knownMatches = {};

  ValueExpressionFactory? findFor(InterfaceType typeToConvert,
      [Set<InterfaceType> typesBeingSearched = const {}]) {
    if (_knownMatches.containsKey(typeToConvert)) {
      return _knownMatches[typeToConvert];
    }

    for (var valueExpressionFactory in this) {
      var result = valueExpressionFactory.supports(
          typeToConvert);
      if (result is Supported) {
        _knownMatches[typeToConvert] = valueExpressionFactory;
        return valueExpressionFactory;
      }
      if (result is SupportedIfTypesAreSupported) {
        typesBeingSearched = {...typesBeingSearched, typeToConvert};
        // removing queriesBeingSearched from typesThatMustBeSupported (if any)
        // to prevent infinite recursive calls
        var queriesThatMustBeSupported = result.typesThatMustBeSupported
          ..removeAll(typesBeingSearched);
        if (supportsAll(queriesThatMustBeSupported)) {
          return valueExpressionFactory;
        }
      }
    }
    return null;
  }

  bool supportsAll(Set<InterfaceType> queryThatMustBeSupported,
          [Set<InterfaceType> typesBeingSearched = const {}]) =>
      queryThatMustBeSupported
          .every((query) => supports(query, typesBeingSearched));

  bool supports(InterfaceType typeToConvert, [Set<InterfaceType> typesBeingSearched = const {}]) =>
      findFor(typeToConvert, typesBeingSearched) != null;
}

code.Type createType(Element element, bool nullable) => code.Type(
      element.displayName,
      libraryUri: createLibraryUri(element),
      nullable: nullable,
    );

String? createLibraryUri(Element element) {
  String libraryUri = element.library?.uri.toString() ?? '';
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

bool isNullable(DartType dartType) =>
    dartType.nullabilitySuffix == NullabilitySuffix.question;
