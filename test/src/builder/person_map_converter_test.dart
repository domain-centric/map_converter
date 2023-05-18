// ignore_for_file: avoid_relative_lib_imports

import 'dart:convert';

import 'package:collection/collection.dart';
import '../../../example/lib/person/person.data.converter.map.dart';
import '../../../example/lib/person/person.domain.dart';
import 'package:test/test.dart';
import 'package:yaml_writer/yaml_writer.dart';

main() {
  group('toMap', () {
    test('MikeSmith()', () {
      var person = MikeSmith();
      print('========================${person.name}=====================]=');
      print(person);
      print(PersonMap(person));
      print(jsonEncode(personToMap(person)));
      print(YAMLWriter().write(personToMap(person)));
      expect(personToMap(person), PersonMap(person));
    });

    test('JaneSmith()', () {
      var person = JaneSmith();
      print('========================${person.name}=====================]=');
      print(person);
      print(PersonMap(person));
      print(jsonEncode(personToMap(person)));
      print(YAMLWriter().write(personToMap(person)));
      expect(personToMap(person), PersonMap(person));
    });

    test('BobSmith()', () {
      var person = BobSmith();
      print('========================${person.name}=====================]=');
      print(person);
      print(PersonMap(person));
      print(jsonEncode(personToMap(person)));
      print(YAMLWriter().write(personToMap(person)));
      expect(personToMap(person), PersonMap(person));
    });
  });
}

class BobSmith extends Person {
  BobSmith()
      : super(
          'Bob Smith',
          dateOfBirth: DateTime(1974, 1, 21),
          children: [MikeSmith(), JaneSmith()],
        ) {
    hobby = 'Cooking';
    gender = Gender.male;
  }
}

class MikeSmith extends Person {
  MikeSmith()
      : super(
          'Mike Smith',
          dateOfBirth: DateTime(2003, 10, 19),
        ) {
    gender = Gender.male;
  }
}

class PersonMap extends DelegatingMap<String, dynamic> {
  PersonMap(Person person)
      : super({
          'name': person.name,
          'dateOfBirth': person.dateOfBirth.toIso8601String(),
          'children':
              person.children.map((person) => personToMap(person)).toList(),
          'hobby': person.hobby,
          'gender': person.gender.name
        });
}

class JaneSmith extends Person {
  JaneSmith() : super('Jane Smith', dateOfBirth: DateTime(2006, 3, 2)) {
    gender = Gender.female;
  }
}
