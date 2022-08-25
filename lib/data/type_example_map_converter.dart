import 'package:map_converter/data/person/person_map_converter.dart' as i2;
import 'package:map_converter/data/type_example_map_converter.dart' as i3;
import 'package:map_converter/domain/person/person.dart' as i4;
import 'package:map_converter/domain/type_example.dart' as i1;

/// Do not make changes to this file!
/// This file is generated by: MapConverterBuilder
/// On: 2022-08-25 07:55:30.115713
/// From: package:map_converter/domain/type_example.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: TODO
Map<String, dynamic> typeExampleToMap(i1.TypeExample typeExample) => {
      'myString': typeExample.myString,
      'myNullableString': typeExample.myNullableString,
      'myNum': typeExample.myNum,
      'myNullableNum': typeExample.myNullableNum,
      'myInt': typeExample.myInt,
      'myNullableInt': typeExample.myNullableInt,
      'myDouble': typeExample.myDouble,
      'myNullableDouble': typeExample.myNullableDouble,
      'myBool': typeExample.myBool,
      'myNullableBool': typeExample.myNullableBool,
      'myEnum': typeExample.myEnum.name,
      'myNullableEnum': typeExample.myNullableEnum?.name,
      'myUri': typeExample.myUri.toString(),
      'myNullableUri': typeExample.myNullableUri?.toString(),
      'myBigInt': typeExample.myBigInt.toString(),
      'myNullableBigInt': typeExample.myNullableBigInt?.toString(),
      'myDateTime': typeExample.myDateTime.toIso8601String(),
      'myNullableDateTime': typeExample.myNullableDateTime?.toIso8601String(),
      'myDuration': typeExample.myDuration.inMicroseconds,
      'myNullableDuration': typeExample.myNullableDuration?.inMicroseconds,
      'myPerson': i2.personToMap(typeExample.myPerson),
      'myNullablePerson': typeExample.myNullablePerson == null
          ? null
          : i2.personToMap(typeExample.myNullablePerson!),
      'myExample': i3.typeExampleToMap(typeExample.myExample),
      'myNullableExample': typeExample.myNullableExample == null
          ? null
          : i3.typeExampleToMap(typeExample.myNullableExample!)
    };
i1.TypeExample mapToTypeExample(Map<String, dynamic> typeExampleMap) =>
    i1.TypeExample()
      ..myString = typeExampleMap['myString'] as String
      ..myNullableString = typeExampleMap['myNullableString'] as String?
      ..myNum = typeExampleMap['myNum'] as num
      ..myNullableNum = typeExampleMap['myNullableNum'] as num?
      ..myInt = typeExampleMap['myInt'] as int
      ..myNullableInt = typeExampleMap['myNullableInt'] as int?
      ..myDouble = (typeExampleMap['myDouble'] as num).toDouble()
      ..myNullableDouble =
          (typeExampleMap['myNullableDouble'] as num?)?.toDouble()
      ..myBool = typeExampleMap['myBool'] as bool
      ..myNullableBool = typeExampleMap['myNullableBool'] as bool?
      ..myEnum =
          i4.Gender.values.firstWhere((e) => e.name == typeExampleMap['myEnum'])
      ..myNullableEnum = typeExampleMap['myNullableEnum'] == null
          ? null
          : i4.Gender.values
              .firstWhere((e) => e.name == typeExampleMap['myNullableEnum'])
      ..myUri = Uri.parse(typeExampleMap['myUri'] as String)
      ..myNullableUri = typeExampleMap['myNullableUri'] == null
          ? null
          : Uri.parse(typeExampleMap['myNullableUri'] as String)
      ..myBigInt = BigInt.parse(typeExampleMap['myBigInt'] as String)
      ..myNullableBigInt = typeExampleMap['myNullableBigInt'] == null
          ? null
          : BigInt.parse(typeExampleMap['myNullableBigInt'] as String)
      ..myDateTime = DateTime.parse(typeExampleMap['myDateTime'] as String)
      ..myNullableDateTime = typeExampleMap['myNullableDateTime'] == null
          ? null
          : DateTime.parse(typeExampleMap['myNullableDateTime'] as String)
      ..myDuration = Duration(microseconds: typeExampleMap['myDuration'] as int)
      ..myNullableDuration = typeExampleMap['myNullableDuration'] == null
          ? null
          : Duration(microseconds: typeExampleMap['myNullableDuration'] as int)
      ..myPerson =
          i2.mapToPerson(typeExampleMap['myPerson'] as Map<String, dynamic>)
      ..myNullablePerson = typeExampleMap['myNullablePerson'] == null
          ? null
          : i2.mapToPerson(
              typeExampleMap['myNullablePerson'] as Map<String, dynamic>)
      ..myExample = i3
          .mapToTypeExample(typeExampleMap['myExample'] as Map<String, dynamic>)
      ..myNullableExample = typeExampleMap['myNullableExample'] == null
          ? null
          : i3.mapToTypeExample(
              typeExampleMap['myNullableExample'] as Map<String, dynamic>);
