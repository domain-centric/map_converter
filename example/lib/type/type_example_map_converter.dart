import '../../../example/lib/type/type_example.dart' as i1;
import '../../../example/lib/person/person.dart' as i2;
import '../../../example/lib/person/person_map_converter.dart' as i3;
import '../../../example/lib/type/type_example_map_converter.dart' as i4;

/// Do not make changes to this file!
/// This file is generated by package: map_converter
/// Input: map_converter/example/lib/type/type_example.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: https://pub.dev/packages/map_converter
i1.Example mapToExample(Map<String, dynamic> exampleMap) =>
    i1.Example()
      ..myBool = exampleMap['myBool'] as bool
      ..myNullableBool = exampleMap['myNullableBool'] as bool?
      ..myEnum = i2.Gender.values.firstWhere(
        (enumValue) => enumValue.name == exampleMap['myEnum'],
      )
      ..myNullableEnum =
          exampleMap['myNullableEnum'] == null
              ? null
              : i2.Gender.values.firstWhere(
                (enumValue) => enumValue.name == exampleMap['myNullableEnum'],
              )
      ..myUri = Uri.parse(exampleMap['myUri'] as String)
      ..myNullableUri =
          exampleMap['myNullableUri'] == null
              ? null
              : Uri.parse(exampleMap['myNullableUri'] as String)
      ..myBigInt = BigInt.parse(exampleMap['myBigInt'] as String)
      ..myNullableBigInt =
          exampleMap['myNullableBigInt'] == null
              ? null
              : BigInt.parse(exampleMap['myNullableBigInt'] as String)
      ..myDateTime = DateTime.parse(exampleMap['myDateTime'] as String)
      ..myNullableDateTime =
          exampleMap['myNullableDateTime'] == null
              ? null
              : DateTime.parse(exampleMap['myNullableDateTime'] as String)
      ..myDuration = Duration(microseconds: exampleMap['myDuration'] as int)
      ..myNullableDuration =
          exampleMap['myNullableDuration'] == null
              ? null
              : Duration(microseconds: exampleMap['myNullableDuration'] as int)
      ..myPerson = i3.mapToPerson(
        exampleMap['myPerson'] as Map<String, dynamic>,
      )
      ..myNullablePerson =
          exampleMap['myNullablePerson'] == null
              ? null
              : i3.mapToPerson(
                exampleMap['myNullablePerson'] as Map<String, dynamic>,
              )
      ..myExample = i4.mapToExample(
        exampleMap['myExample'] as Map<String, dynamic>,
      )
      ..myNullableExample =
          exampleMap['myNullableExample'] == null
              ? null
              : i4.mapToExample(
                exampleMap['myNullableExample'] as Map<String, dynamic>,
              );
Map<String, dynamic> exampleToMap(i1.Example example) => {
  'myBool': example.myBool,
  'myNullableBool': example.myNullableBool,
  'myEnum': example.myEnum.name,
  'myNullableEnum': example.myNullableEnum?.name,
  'myUri': example.myUri.toString(),
  'myNullableUri': example.myNullableUri?.toString(),
  'myBigInt': example.myBigInt.toString(),
  'myNullableBigInt': example.myNullableBigInt?.toString(),
  'myDateTime': example.myDateTime.toIso8601String(),
  'myNullableDateTime': example.myNullableDateTime?.toIso8601String(),
  'myDuration': example.myDuration.inMicroseconds,
  'myNullableDuration': example.myNullableDuration?.inMicroseconds,
  'myPerson': i3.personToMap(example.myPerson),
  'myNullablePerson':
      example.myNullablePerson == null
          ? null
          : i3.personToMap(example.myNullablePerson!),
  'myExample': i4.exampleToMap(example.myExample),
  'myNullableExample':
      example.myNullableExample == null
          ? null
          : i4.exampleToMap(example.myNullableExample!),
};
