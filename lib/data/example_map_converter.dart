import 'package:map_converter/data/example_map_converter.dart' as _i3;
import 'package:map_converter/data/person/person_map_converter.dart' as _i2;
import 'package:map_converter/domain/example.dart' as _i1;
import 'package:map_converter/domain/person/person.dart' as _i4;

/// Do not make changes to this file!
/// This file is generated by: MapConverterBuilder
/// On: 2022-08-23 21:08:16.711517
/// From: /map_converter/lib/domain/example.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: TODO
Map<String, dynamic> exampleToMap(_i1.Example example) => {
      'myString': example.myString,
      'myNullableString': example.myNullableString,
      'myNum': example.myNum,
      'myNullableNum': example.myNullableNum,
      'myInt': example.myInt,
      'myNullableInt': example.myNullableInt,
      'myDouble': example.myDouble,
      'myNullableDouble': example.myNullableDouble,
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
      'myPerson': _i2.personToMap(example.myPerson),
      'myNullablePerson': example.myNullablePerson == null
          ? null
          : _i2.personToMap(example.myNullablePerson!),
      'myExample': _i3.exampleToMap(example.myExample),
      'myNullableExample': example.myNullableExample == null
          ? null
          : _i3.exampleToMap(example.myNullableExample!)
    };

_i1.Example mapToExample(Map<String, dynamic> exampleMap) => _i1.Example()
  ..myString = exampleMap['myString'] as String
  ..myNullableString = exampleMap['myNullableString'] as String?
  ..myNum = exampleMap['myNum'] as num
  ..myNullableNum = exampleMap['myNullableNum'] as num?
  ..myInt = exampleMap['myInt'] as int
  ..myNullableInt = exampleMap['myNullableInt'] as int?
  ..myDouble = (exampleMap['myDouble'] as num).toDouble()
  ..myNullableDouble = (exampleMap['myNullableDouble'] as num?)?.toDouble()
  ..myBool = exampleMap['myBool'] as bool
  ..myNullableBool = exampleMap['myNullableBool'] as bool?
  ..myEnum = _i4.Gender.values.firstWhere((e) => e.name == exampleMap['myEnum'])
  ..myNullableEnum = exampleMap['myNullableEnum'] == null
      ? null
      : _i4.Gender.values
          .firstWhere((e) => e.name == exampleMap['myNullableEnum'])
  ..myUri = Uri.parse(exampleMap['myUri'] as String)
  ..myNullableUri = exampleMap['myNullableUri'] == null
      ? null
      : Uri.parse(exampleMap['myNullableUri'] as String)
  ..myBigInt = BigInt.parse(exampleMap['myBigInt'] as String)
  ..myNullableBigInt = exampleMap['myNullableBigInt'] == null
      ? null
      : BigInt.parse(exampleMap['myNullableBigInt'] as String)
  ..myDateTime = DateTime.parse(exampleMap['myDateTime'] as String)
  ..myNullableDateTime = exampleMap['myNullableDateTime'] == null
      ? null
      : DateTime.parse(exampleMap['myNullableDateTime'] as String)
  ..myDuration = Duration(microseconds: exampleMap['myDuration'] as int)
  ..myNullableDuration = exampleMap['myNullableDuration'] == null
      ? null
      : Duration(microseconds: exampleMap['myNullableDuration'] as int)
  ..myPerson = _i2.mapToPerson(exampleMap['myPerson'] as Map<String, dynamic>)
  ..myNullablePerson = exampleMap['myNullablePerson'] == null
      ? null
      : _i2.mapToPerson(exampleMap['myNullablePerson'] as Map<String, dynamic>)
  ..myExample =
      _i3.mapToExample(exampleMap['myExample'] as Map<String, dynamic>)
  ..myNullableExample = exampleMap['myNullableExample'] == null
      ? null
      : _i3.mapToExample(
          exampleMap['myNullableExample'] as Map<String, dynamic>);
