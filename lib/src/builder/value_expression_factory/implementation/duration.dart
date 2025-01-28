import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';


class DurationExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.element.displayName == 'Duration' &&
      typeToConvert.element.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.getProperty('inMicroseconds', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var result = code.Expression.callConstructor(code.Type.ofDuration(),
        parameterValues: code.ParameterValues([
          code.ParameterValue.named(
              'microseconds', source.asA(code.Type.ofInt()))
        ]));
    return wrapWithIfNullWhenNullable(nullable, source, result);
  }
}
