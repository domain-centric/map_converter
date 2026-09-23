import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class StringExpressionFactory extends ValueExpressionFactory {
  @override
  SupportResult supports(
    InterfaceType typeToConvert,
  ) =>
      SupportResult.of(typeToConvert.isDartCoreString);

  @override
  MapValueToObjectExpressionFunction get mapValueToObjectFunction => (
    MapConverterLibraryAssetIdFactory idFactory,
    code.Expression source,
    InterfaceType typeToConvert,
  ) =>
      source.asA(code.Type.ofString(nullable: isNullable(typeToConvert)));

  @override
  ObjectToMapValueExpressionFunction get objectToMapValueFunction => (
    MapConverterLibraryAssetIdFactory idFactory,
    code.Expression source,
    InterfaceType typeToConvert,
  ) =>
      source;
}
