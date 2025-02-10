import '../../../example/lib/type/list.dart' as i1;
import '../../../example/lib/person/person.dart' as i2;
import '../../../example/lib/person/person_map_converter.dart' as i3;

/// Do not make changes to this file!
/// This file is generated by package: map_converter
/// Input: map_converter/example/lib/type/list.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: https://pub.dev/packages/map_converter
i1.Example mapToExample(Map<String, dynamic> exampleMap) => i1.Example()
  ..boolList = exampleMap['boolList']
      .map((listElement) => listElement as bool)
      .toList()
      .cast<bool>()
  ..boolListWithNullableBools = exampleMap['boolListWithNullableBools']
      .map((listElement) => listElement as bool?)
      .toList()
      .cast<bool?>()
  ..nullableBoolList = exampleMap['nullableBoolList']
      ?.map((listElement) => listElement as bool)
      .toList()
      .cast<bool>()
  ..nullableBoolListWithNullableBools =
      exampleMap['nullableBoolListWithNullableBools']
          ?.map((listElement) => listElement as bool?)
          .toList()
          .cast<bool?>()
  ..numList = exampleMap['numList']
      .map((listElement) => listElement as num)
      .toList()
      .cast<num>()
  ..nullableNumList = exampleMap['nullableNumList']
      ?.map((listElement) => listElement as num?)
      .toList()
      .cast<num?>()
  ..intList = exampleMap['intList']
      .map((listElement) => (listElement as num).toInt())
      .toList()
      .cast<int>()
  ..nullableIntList = exampleMap['nullableIntList']
      ?.map((listElement) => (listElement as num?)?.toInt())
      .toList()
      .cast<int?>()
  ..doubleList = exampleMap['doubleList']
      .map((listElement) => (listElement as num).toDouble())
      .toList()
      .cast<double>()
  ..nullableDoubleList = exampleMap['nullableDoubleList']
      ?.map((listElement) => (listElement as num?)?.toDouble())
      .toList()
      .cast<double?>()
  ..stringList = exampleMap['stringList']
      .map((listElement) => listElement as String)
      .toList()
      .cast<String>()
  ..nullableStringList = exampleMap['nullableStringList']
      ?.map((listElement) => listElement as String?)
      .toList()
      .cast<String?>()
  ..uriList = exampleMap['uriList']
      .map((listElement) => Uri.parse(listElement as String))
      .toList()
      .cast<Uri>()
  ..nullableUriList = exampleMap['nullableUriList']
      ?.map(
        (listElement) =>
            listElement == null ? null : Uri.parse(listElement as String),
      )
      .toList()
      .cast<Uri?>()
  ..bigIntList = exampleMap['bigIntList']
      .map((listElement) => BigInt.parse(listElement as String))
      .toList()
      .cast<BigInt>()
  ..nullableBigIntList = exampleMap['nullableBigIntList']
      ?.map(
        (listElement) =>
            listElement == null ? null : BigInt.parse(listElement as String),
      )
      .toList()
      .cast<BigInt?>()
  ..dateTimeList = exampleMap['dateTimeList']
      .map((listElement) => DateTime.parse(listElement as String))
      .toList()
      .cast<DateTime>()
  ..nullableDateTimeList = exampleMap['nullableDateTimeList']
      ?.map(
        (listElement) =>
            listElement == null ? null : DateTime.parse(listElement as String),
      )
      .toList()
      .cast<DateTime?>()
  ..durationList = exampleMap['durationList']
      .map((listElement) => Duration(microseconds: listElement as int))
      .toList()
      .cast<Duration>()
  ..nullableDurationList = exampleMap['nullableDurationList']
      ?.map(
        (listElement) => listElement == null
            ? null
            : Duration(microseconds: listElement as int),
      )
      .toList()
      .cast<Duration?>()
  ..genderList = exampleMap['genderList']
      .map(
        (listElement) => i2.Gender.values.firstWhere(
          (enumValue) => enumValue.name == listElement,
        ),
      )
      .toList()
      .cast<i2.Gender>()
  ..nullableGenderList = exampleMap['nullableGenderList']
      ?.map(
        (listElement) => listElement == null
            ? null
            : i2.Gender.values.firstWhere(
                (enumValue) => enumValue.name == listElement,
              ),
      )
      .toList()
      .cast<i2.Gender?>()
  ..personList = exampleMap['personList']
      .map(
        (listElement) => i3.mapToPerson(listElement as Map<String, dynamic>),
      )
      .toList()
      .cast<i2.Person>()
  ..nullablePersonList = exampleMap['nullablePersonList']
      ?.map(
        (listElement) => listElement == null
            ? null
            : i3.mapToPerson(listElement as Map<String, dynamic>),
      )
      .toList()
      .cast<i2.Person?>();
Map<String, dynamic> exampleToMap(i1.Example example) => {
      'boolList': example.boolList,
      'boolListWithNullableBools': example.boolListWithNullableBools,
      'nullableBoolList': example.nullableBoolList,
      'nullableBoolListWithNullableBools':
          example.nullableBoolListWithNullableBools,
      'numList': example.numList,
      'nullableNumList': example.nullableNumList,
      'intList': example.intList,
      'nullableIntList': example.nullableIntList,
      'doubleList': example.doubleList,
      'nullableDoubleList': example.nullableDoubleList,
      'stringList': example.stringList,
      'nullableStringList': example.nullableStringList,
      'uriList': example.uriList
          .map((Uri listElement) => listElement.toString())
          .toList(),
      'nullableUriList': example.nullableUriList
          ?.map((Uri? listElement) => listElement?.toString())
          .toList(),
      'bigIntList': example.bigIntList
          .map((BigInt listElement) => listElement.toString())
          .toList(),
      'nullableBigIntList': example.nullableBigIntList
          ?.map((BigInt? listElement) => listElement?.toString())
          .toList(),
      'dateTimeList': example.dateTimeList
          .map((DateTime listElement) => listElement.toIso8601String())
          .toList(),
      'nullableDateTimeList': example.nullableDateTimeList
          ?.map((DateTime? listElement) => listElement?.toIso8601String())
          .toList(),
      'durationList': example.durationList
          .map((Duration listElement) => listElement.inMicroseconds)
          .toList(),
      'nullableDurationList': example.nullableDurationList
          ?.map((Duration? listElement) => listElement?.inMicroseconds)
          .toList(),
      'genderList': example.genderList
          .map((i2.Gender listElement) => listElement.name)
          .toList(),
      'nullableGenderList': example.nullableGenderList
          ?.map((i2.Gender? listElement) => listElement?.name)
          .toList(),
      'personList': example.personList
          .map((i2.Person listElement) => i3.personToMap(listElement))
          .toList(),
      'nullablePersonList': example.nullablePersonList
          ?.map(
            (i2.Person? listElement) =>
                listElement == null ? null : i3.personToMap(listElement),
          )
          .toList(),
    };
