import 'package:analyzer/dart/element/type.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:recase/recase.dart';

class DomainObjectExpressionFactory implements ValueExpressionFactory {
  final domainClassFactory = DomainClassFactory();

  @override
  SupportResult supports(InterfaceType typeToConvert) {
    if (!domainClassFactory.isDomainClass(typeToConvert.element)) {
      return const NotSupported();
    }
    return const Supported();

    ///SupportedIfTypesAreSupported(domainClassFactory.constructorsWithRequiredFields(typeToConvert.element));
  }

  @override
  FromMapValueExpressionFunction get fromMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var nullable = isNullable(typeToConvert);
        var mapperClassName = '${typeToConvert.element.displayName}Mapper';
        var mapperClassLibraryUri = createRelativeLibraryUri(
            idFactory.createOutputUriForType(typeToConvert));
        var result = code.Expression.callConstructor(
                code.Type(mapperClassName, libraryUri: mapperClassLibraryUri),
                isConst: true)
            .callMethod('fromMap',
                parameterValues: code.ParameterValues([
                  code.ParameterValue(source.asA(code.Type.ofMap(
                    keyType: code.Type.ofString(),
                    valueType: code.Type.ofDynamic(),
                  )))
                ]));
        return wrapWithIfNullWhenNullable(nullable, source, result);
      };

  @override
  ToMapValueExpressionFunction get toMapValue => (
        MapConverterLibraryAssetIdFactory idFactory,
        code.Expression source,
        InterfaceType typeToConvert,
      ) {
        var nullable = isNullable(typeToConvert);
        var mapperClassName = '${typeToConvert.element.displayName}Mapper';
        var mapperClassLibraryUri = createRelativeLibraryUri(
            idFactory.createOutputUriForType(typeToConvert));
        var sourceIsProperty = source.toUnFormattedString().contains('.');
        var result = code.Expression.callConstructor(
                code.Type(mapperClassName, libraryUri: mapperClassLibraryUri),
                isConst: true)
            .callMethod('toMap',
                parameterValues: code.ParameterValues([
                  code.ParameterValue(code.Expression([
                    source,
                    if (nullable && sourceIsProperty) code.Code('!'),
                  ]))
                ]));
        return wrapWithIfNullWhenNullable(nullable, source, result);
      };
}
