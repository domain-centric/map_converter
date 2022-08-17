import '../domain/example_object2.dart';
///TODO to be generated

Person toPerson(Map<String, dynamic> map) =>
      Person(
        name: map['name'] as String,
        dateOfBirth: DateTime.parse(map['dateOfBirth'] as String),
              children: (map['children'] as List<dynamic>)
            .map((e) => toPerson(e as Map<String, dynamic>))
            .toList(),
      )
        ..hobby = map['hobby'] as String
        ..gender = Gender.values.firstWhere((gender) => gender.name==map['gender']);

Map<String, dynamic> toMap(Person person) =>
      <String, dynamic>{
        'name': person.name,
        'dateOfBirth': person.dateOfBirth.toIso8601String(),
        'children': person.children.map((person) => toMap(person)).toList(),
        'hobby': person.hobby,
        'gender': person.gender.name
      };
