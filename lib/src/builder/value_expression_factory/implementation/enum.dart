import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';



class EnumExpressionFactory implements ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      typeToConvert.element.toString().startsWith('enum ');

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) =>
      source.getProperty('name', ifNullReturnNull: nullable);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var propertyType = createType(typeToConvert.element, false);
    var result = code.Expression.ofType(propertyType)
        .getProperty('values')
        .callMethod('firstWhere',
            parameterValues: code.ParameterValues(([
              code.ParameterValue(code.Expression([
                code.Code('(enumValue) => enumValue.name=='),
                source,
              ]))
            ])));

    return wrapWithIfNullWhenNullable(nullable, source, result);
  }
}
