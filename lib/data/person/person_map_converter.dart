import 'package:map_converter/data/person/person_map_converter.dart' as i2;
import 'package:map_converter/domain/person/person.dart' as i1;

/// Do not make changes to this file!
/// This file is generated by: MapConverterBuilder
/// On: 2022-09-14 16:36:14.005997
/// From: package:map_converter/domain/person/person.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: TODO
Map<String, dynamic> personToMap(i1.Person person) => {
      'name': person.name,
      'dateOfBirth': person.dateOfBirth.toIso8601String(),
      'children': person.children
          .map((i1.Person listElement) => i2.personToMap(listElement))
          .toList(),
      'hobby': person.hobby,
      'gender': person.gender.name
    };

i1.Person mapToPerson(Map<String, dynamic> personMap) =>
    i1.Person(personMap['name'] as String,
        dateOfBirth: DateTime.parse(personMap['dateOfBirth'] as String),
        children: personMap['children']
            .map((listElement) =>
                i2.mapToPerson(listElement as Map<String, dynamic>))
            .toList())
      ..hobby = personMap['hobby'] as String
      ..gender = i1.Gender.values
          .firstWhere((enumValue) => enumValue.name == personMap['gender']);
