import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class UriExpressionFactory extends ValueExpressionFactory {
  @override
  SupportResult supports(
    InterfaceType typeToConvert,
  ) =>
      SupportResult.of(typeToConvert.element.displayName == 'Uri' &&
          typeToConvert.element.library.name == 'dart.core');

  @override
  FromMapValueExpressionFunction get fromMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var result = code.Expression.ofType(code.Type.ofUri()).callMethod(
            'parse',
            parameterValues: code.ParameterValues(
                [code.ParameterValue(source.asA(code.Type.ofString()))]));
        return wrapWithIfNullWhenNullable(
            isNullable(typeToConvert), source, result);
      };

  @override
  ToMapValueExpressionFunction get toMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) =>
          source.callMethod('toString',
              ifNullReturnNull: isNullable(typeToConvert));
}
