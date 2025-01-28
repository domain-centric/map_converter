import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:recase/recase.dart';


class DomainObjectExpressionFactory implements ValueExpressionFactory {
  final domainClassFactory = DomainClassFactory();

  @override
  bool canConvert(
    Property? propertyAnnotation,
    InterfaceElement classElement,
    InterfaceType typeToConvert,
  ) =>
      classElement == typeToConvert.element // prevent endless round trips
      ||
      domainClassFactory
          .isDomainClassWithSupportedPropertyTypes(typeToConvert.element);

  @override
  code.Expression mapValueToObject(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var functionName =
        'mapTo${typeToConvert.element.displayName}';
    var result = code.Expression.callMethodOrFunction(functionName,
        libraryUri: createRelativeLibraryUri(
            idFactory.createOutputUriForType(typeToConvert)),
        parameterValues: code.ParameterValues([
          code.ParameterValue(source.asA(code.Type.ofMap(
            keyType: code.Type.ofString(),
            valueType: code.Type.ofDynamic(),
          )))
        ]));
    return wrapWithIfNullWhenNullable(nullable, source, result);
  }

  @override
  code.Expression objectToMapValue(
    MapConverterLibraryAssetIdFactory idFactory,
    PropertyWithBuildInfo property,
    code.Expression source,
    InterfaceType typeToConvert, {
    required bool nullable,
  }) {
    var functionName =
        '${typeToConvert.element.displayName.camelCase}ToMap';
    var sourceIsProperty =
        code.CodeFormatter().unFormatted(source).contains('.');
    var result = code.Expression.callMethodOrFunction(functionName,
        libraryUri: createRelativeLibraryUri(
            idFactory.createOutputUriForType(typeToConvert)),
        parameterValues: code.ParameterValues([
          code.ParameterValue(code.Expression([
            source,
            if (nullable && sourceIsProperty) code.Code('!'),
          ]))
        ]));
    return wrapWithIfNullWhenNullable(nullable, source, result);
  }
}
