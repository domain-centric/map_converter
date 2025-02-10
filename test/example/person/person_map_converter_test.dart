// ignore_for_file: avoid_relative_lib_imports

import 'package:collection/collection.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';
import '../../../example/lib/person/person.dart';
import '../../../example/lib/person/person_map_converter.dart';

main() {
  group('personToMap', () {
    test('MikeSmith()', () {
      var person = MikeSmith();
      var personMap = personToMap(person);
      personMap.should.be(PersonMap(person));
    });

    test('JaneSmith()', () {
      var person = JaneSmith();
      var personMap = personToMap(person);
      personMap.should.be(PersonMap(person));
    });

    test('BobSmith()', () {
      var person = BobSmith();
      var personMap = personToMap(person);
      personMap.should.be(PersonMap(person));
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

class JaneSmith extends Person {
  JaneSmith() : super('Jane Smith', dateOfBirth: DateTime(2006, 3, 2)) {
    gender = Gender.female;
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
