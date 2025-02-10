import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class EnumExpressionFactory implements ValueExpressionFactory {
  @override
  SupportResult supports(
    InterfaceType typeToConvert,
    Property? propertyAnnotation,
  ) =>
      SupportResult.of(typeToConvert.element.toString().startsWith('enum '));

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert,
  ) {
    var nullable = isNullable(typeToConvert);
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

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert,
  ) =>
      source.getProperty(
        'name',
        ifNullReturnNull: isNullable(typeToConvert),
      );
}
