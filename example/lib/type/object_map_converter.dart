import '../../../example/lib/type/object.dart' as i1;
import '../../../example/lib/person/person_map_converter.dart' as i2;

/// Do not make changes to this file!
/// This file is generated by package: map_converter
/// Input: map_converter/example/lib/type/object.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: https://pub.dev/packages/map_converter
i1.Example mapToExample(Map<String, dynamic> exampleMap) => i1.Example()
  ..myPerson = i2.mapToPerson(
    exampleMap['myPerson'] as Map<String, dynamic>,
  )
  ..myNullablePerson = exampleMap['myNullablePerson'] == null
      ? null
      : i2.mapToPerson(
          exampleMap['myNullablePerson'] as Map<String, dynamic>,
        );
Map<String, dynamic> exampleToMap(i1.Example example) => {
      'myPerson': i2.personToMap(example.myPerson),
      'myNullablePerson': example.myNullablePerson == null
          ? null
          : i2.personToMap(example.myNullablePerson!),
    };
