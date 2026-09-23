import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class DoubleExpressionFactory extends ValueExpressionFactory {
  @override
  SupportResult supports(
    InterfaceType typeToConvert,
  ) =>
      SupportResult.of(typeToConvert.isDartCoreDouble);

  @override
  FromMapValueExpressionFunction get fromMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var nullable = isNullable(typeToConvert);
        return code.Expression.betweenParentheses(
                source.asA(code.Type.ofNum(nullable: nullable)))
            .callMethod('toDouble', ifNullReturnNull: nullable);
      };

  @override
  ToMapValueExpressionFunction get toMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) =>
          source;
}
