import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/map_converter.dart';
import 'package:map_converter/src/builder/map_converter_builder.dart';
import 'package:map_converter/src/builder/mapper_factory/mapper_factory.dart';
import 'package:recase/recase.dart';

/// creates a Mapper class for a class that can have multiple implementations
class PolymorphismMapperFactory implements MapperFactory {
  PolymorphismMeta? _createPolymorphismMeta(Element element) {
    if (!isDomainClass(element)) {
      return null;
    }
    var classElement = element as ClassElement;
    final mapConverterAnnotation = findMapConverterAnnotation(classElement);
    if (mapConverterAnnotation == null) {
      return null;
    }
    return PolymorphismMeta.create(classElement, mapConverterAnnotation);
  }

  bool isDomainClass(Element element) {
    return element is ClassElement &&
        hasMapConverterAnnotation(element) &&
        element.isPublic &&
        element is! EnumElement &&
        element.thisType.allSupertypes
            .none((e) => isListSetMapIteratorType(e.element));
  }

  @override
  code.Class create(
      Element element, MapConverterLibraryAssetIdFactory idFactory) {
    var polymorphism = _createPolymorphismMeta(element)!;
    return PolymorphismMapperClass(polymorphism, idFactory);
  }

  @override
  bool supports(Element element) => _createPolymorphismMeta(element) != null;
}

/// information if there are multiple implementations of a Type
class PolymorphismMeta {
  final ClassElement classElement;

  /// FIXMEfinal String discriminatorKey;
  final Map<InterfaceType, String> subClassTypesAndDiscriminatorKeys;
  final int generateOptions;
  late final bool generateFromMapValueMethod =
      generateOptions & GenerateOptions.fromMap > 0;
  late final bool generateToMapValueMethod =
      generateOptions & GenerateOptions.toMap > 0;
  late final bool generateSchemaField =
      generateOptions & GenerateOptions.schema > 0;

  PolymorphismMeta(
      {required this.classElement,

      /// FIXME  required this.discriminatorKey,
      required this.subClassTypesAndDiscriminatorKeys,
      required this.generateOptions});

  static PolymorphismMeta? create(
      ClassElement classElement, DartObject mapConverterAnnotation) {
    var subClassTypes = mapConverterAnnotation
        .getField("includeSubClasses")
        ?.toListValue()
        ?.map((subClass) => _subClassType(subClass))
        .whereType<InterfaceType>();

    if (subClassTypes == null || subClassTypes.isEmpty) {
      return null;
    }
    var subClassTypesAndDiscriminatorKeys = {
      for (var subClass in subClassTypes) subClass: _discriminatorKey(subClass)
    };
    var generateOptions =
        mapConverterAnnotation.getField('generateOptions')?.toIntValue() ??
            GenerateOptions.all;
    return PolymorphismMeta(
      classElement: classElement,
      subClassTypesAndDiscriminatorKeys: subClassTypesAndDiscriminatorKeys,
      generateOptions: generateOptions,
    );
  }

  static InterfaceType? _subClassType(DartObject subClass) {
    var dartType = subClass.toTypeValue();
    if (dartType == null ||
        dartType is! InterfaceType ||
        dartType.element is! ClassElement) {
      return null;
    }
    if (findMapConverterAnnotation(dartType.element as ClassElement) == null) {
      log.warning(
          'Sub-class: ${dartType.element.name} needs a MapConverter annotation');
    }
    return dartType;
  }

  /// returns a MapEntry of the sub-class and its discriminator key
  static String _discriminatorKey(InterfaceType subClass) {
    var subClassElement = subClass.element as ClassElement;
    var subClassMapConverterAnnotation =
        findMapConverterAnnotation(subClassElement);
    if (subClassMapConverterAnnotation == null) {
      return '_type';
    }
    return findDiscriminatorKey(subClassElement) ?? '_type';
  }

  // static String _discriminatorKey(DartObject mapConverterAnnotation) {
  //   var discriminatorKey =
  //       mapConverterAnnotation.getField("discriminatorKey")?.toStringValue();
  //   if (discriminatorKey == null || discriminatorKey.trim().isEmpty) {
  //     return '_type';
  //   }
  //   return discriminatorKey;
  // }
}

class PolymorphismMapperClass extends code.Class {
  PolymorphismMapperClass(PolymorphismMeta polymorphism,
      MapConverterLibraryAssetIdFactory idFactory)
      : super(_name(polymorphism), constructors: [
          _constructor(polymorphism)
        ], methods: [
          if (polymorphism.generateFromMapValueMethod)
            FromMapValueMethod(polymorphism, idFactory),
          if (polymorphism.generateToMapValueMethod)
            ToMapValueMethod(polymorphism, idFactory)
        ], fields: [
          // FIXME
          // if (polymorphism.generateSchemaField)
          //   SchemaField(polymorphism, idFactory)
        ]);

  static String _name(PolymorphismMeta polymorphism) =>
      '${polymorphism.classElement.name!}Mapper';

  static code.Constructor _constructor(PolymorphismMeta polymorphism) =>
      code.Constructor(code.Type(_name(polymorphism)), constant: true);
}

//  Map<String, dynamic> toMap(Animal animal) => switch (animal.runtimeType) {
//         Dog => DogMapper().toMap(animal as Dog),
//         _ => throw Exception('Unsupported type: ${animal.runtimeType}')
//       };

class ToMapValueMethod extends code.Method {
  ToMapValueMethod(
    PolymorphismMeta polymorphism,
    MapConverterLibraryAssetIdFactory idFactory,
  ) : super(
          'toMap',
          _createBody(polymorphism, idFactory),
          parameters: _createParameters(polymorphism, idFactory),
          returnType: _createReturnType(),
        );

  static code.CodeNode _createBody(
    PolymorphismMeta polymorphism,
    MapConverterLibraryAssetIdFactory idFactory,
  ) =>
      code.Expression([
        code.Code('switch (${parameterName(polymorphism)}.runtimeType) '),
        code.Block([
          code.SeparatedValues.forParameters([
            ...polymorphism.subClassTypesAndDiscriminatorKeys.entries.map((entry) =>
                toSwitchCaseExpression(polymorphism, entry.key,  idFactory)),
            code.Code(r"_ => throw Exception('Unsupported type: ${" +
                parameterName(polymorphism) +
                ".runtimeType}')")
          ])
        ]),
      ]);

  static String parameterName(PolymorphismMeta polymorphism) =>
      polymorphism.classElement.name!.camelCase;

  static code.Parameters _createParameters(PolymorphismMeta polymorphism,
          MapConverterLibraryAssetIdFactory idFactory) =>
      code.Parameters([
        code.Parameter.required(parameterName(polymorphism),
            type: code.Type(polymorphism.classElement.name!,
                libraryUri: createLibraryUri(polymorphism.classElement))),
      ]);

  static code.Type _createReturnType() => code.Type.ofMap(
      keyType: code.Type.ofString(), valueType: code.Type.ofDynamic());

  static code.Expression toSwitchCaseExpression(PolymorphismMeta polymorphism,
      InterfaceType subClassType, MapConverterLibraryAssetIdFactory idFactory) {
    var type = code.Type(subClassType.element.name!,
        libraryUri: createRelativeLibraryUri(
            subClassType.element.library.uri.toString()));
    return code.Expression([
      type,
      code.Code(' => '),
      code.Expression.callConstructor(
              code.Type('${subClassType.element.name!}Mapper',
                  libraryUri: createRelativeLibraryUri(
                      idFactory.createOutputUriForType(subClassType))),
              isConst: true)
          .callMethod('toMap',
              parameterValues: code.ParameterValues([
                code.ParameterValue(
                    code.Expression.ofVariable(parameterName(polymorphism))
                        .asA(type))
              ])),
    ]);
  }
}

// i1.Animal fromMap(Map<String, dynamic> map) {
//   if (map['_type'] == 'Dog') {
//     return const i2.DogMapper().fromMap(map);
//   } else if (map['_type'] == 'Cat') {
//     return const i2.CatMapper().fromMap(map);
//   } else if (map['_type'] == 'Bird') {
//     return const i2.BirdMapper().fromMap(map);
//   } else {
//     throw Exception('Unsupported map: $map');
//   }
// }

const String _map = 'map';

class FromMapValueMethod extends code.Method {
  FromMapValueMethod(
    PolymorphismMeta polymorphism,
    MapConverterLibraryAssetIdFactory idFactory,
  ) : super(
          'fromMap',
          _createBody(polymorphism, idFactory),
          parameters: _createFunctionParameters(),
          returnType: _createReturnType(polymorphism),
        );

  static code.CodeNode _createBody(
    PolymorphismMeta polymorphism,
    MapConverterLibraryAssetIdFactory idFactory,
  ) =>
      code.Block([
        ...polymorphism.subClassTypesAndDiscriminatorKeys.entries.map((entry) => _createIfLine(
            entry.key,
            entry.value,
            entry.key == polymorphism.subClassTypesAndDiscriminatorKeys.keys.first
                ? 'if'
                : '} else if',
            idFactory)),
        code.Code("} else { throw Exception('Unsupported map: \$$_map'); }"),
      ]);

  static code.Type _createReturnType(PolymorphismMeta polymorphism) =>
      code.Type(
        polymorphism.classElement.name!,
        libraryUri: createLibraryUri(polymorphism.classElement),
      );

  // static code.Expression _createConstructorCall(DomainClassMeta domainClass,
  //     MapConverterLibraryAssetIdFactory idFactory) {
  //   var name = domainClass.bestConstructor.name;
  //   if (name == 'new') {
  //     name = null;
  //   }
  //   var parameters = _createConstructorParameterValues(domainClass, idFactory);
  //   return code.Expression.callConstructor(createDomainType(domainClass),
  //       name: name, parameterValues: parameters);
  // }

  static code.Expression _createIfLine(
          InterfaceType subClassType,
          String discriminatorKey,
          String ifOrElseIf,
          MapConverterLibraryAssetIdFactory idFactory) =>
      code.Expression([
        code.Code(
            "$ifOrElseIf ($_map['$discriminatorKey'] == '${subClassType.element.name}') {"),
        code.Code("return "),
        code.Expression.callConstructor(
                code.Type('${subClassType.element.name!}Mapper',
                    libraryUri: createRelativeLibraryUri(
                        idFactory.createOutputUriForType(subClassType))),
                isConst: true)
            .callMethod('fromMap',
                parameterValues: code.ParameterValues(
                    [code.ParameterValue(code.Expression.ofVariable(_map))])),
        code.Code(";"),
      ]);

  static code.Parameters _createFunctionParameters() => code.Parameters([
        code.Parameter.required(
          _map,
          type: code.Type.ofMap(
              keyType: code.Type.ofString(), valueType: code.Type.ofDynamic()),
        ),
      ]);
}
