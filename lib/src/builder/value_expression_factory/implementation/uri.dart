import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';


class UriExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.element.displayName == 'Uri' &&
      typeToConvert.element.library.name == 'dart.core';

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.callMethod('toString', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var result = code.Expression.ofType(code.Type.ofUri()).callMethod('parse',
        parameterValues: code.ParameterValues(
            [code.ParameterValue(source.asA(code.Type.ofString()))]));
    return wrapWithIfNullWhenNullable(nullable, source, result);
  }
}


