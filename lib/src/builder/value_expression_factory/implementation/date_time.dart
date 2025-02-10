import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class DateTimeExpressionFactory extends ValueExpressionFactory {
  @override
  SupportResult supports(
    InterfaceType typeToConvert,
    Property? propertyAnnotation,
  ) =>
      SupportResult.of(typeToConvert.element.displayName == 'DateTime' &&
          typeToConvert.element.library.name == 'dart.core');

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert,
  ) {
    var nullable = isNullable(typeToConvert);
    var result = code.Expression.ofType(code.Type.ofDateTime()).callMethod(
        'parse',
        parameterValues: code.ParameterValues(
            [code.ParameterValue(source.asA(code.Type.ofString()))]));
    return wrapWithIfNullWhenNullable(nullable, source, result);
  }

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert,
  ) =>
      source.callMethod('toIso8601String',
          ifNullReturnNull: isNullable(typeToConvert));
}
