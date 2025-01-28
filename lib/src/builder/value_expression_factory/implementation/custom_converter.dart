import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/implementation/value_expression_factory_impl.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';

class CustomConverterExpressionFactory extends ValueExpressionFactory {
  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) => propertyAnnotation is PropertyWithConverterType &&
      propertyAnnotation.converterType != null;

  /// generates something like: i1.MyCustomConverter().fromPrimitive(map['propertyName'])
  @override
  code.Expression mapValueToObject(
          MapConverterLibraryAssetIdFactory idFactory,
          PropertyWithBuildInfo property,
          code.Expression source,
          InterfaceType typeToConvert,
          {required bool nullable}) =>
      code.Expression.callConstructor(
        createType(property.converterType!.element!, false),
      ).callMethod('fromPrimitive',
          parameterValues: code.ParameterValues([code.ParameterValue(source)]));

  /// generates something like: i1.MyCustomConverter().toPrimitive(myObject.dateTime)
  @override
  code.Expression objectToMapValue(
          MapConverterLibraryAssetIdFactory idFactory,
          PropertyWithBuildInfo property,
          code.Expression source,
          InterfaceType typeToConvert,
          {required bool nullable}) =>
      code.Expression.callConstructor(
        createType(property.converterType!.element!, false),
      ).callMethod('toPrimitive',
          parameterValues: code.ParameterValues([code.ParameterValue(source)]));
}
