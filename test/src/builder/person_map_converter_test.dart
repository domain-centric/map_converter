//TODO move to tests and documentation (how to convert from and to Json and YAML)
// import 'dart:convert';
//
// import 'package:collection/collection.dart';
// import 'package:map_converter/data/person_map_converter.dart';
// import 'package:map_converter/domain/person/person.dart';
// import 'package:test/test.dart';
// import 'package:yaml_writer/yaml_writer.dart';
//
// main() {
//   group('toMap', () {
//     test('MikeSmith()', () {
//       var person = MikeSmith();
//       print('========================${person.name}=====================]=');
//       print(person);
//       print(PersonMap(person));
//       print(jsonEncode(toMap(person)));
//       print(YAMLWriter().write(toMap(person)));
//       expect(toMap(person), PersonMap(person));
//     });
//
//     test('JaneSmith()', () {
//       var person = JaneSmith();
//       print('========================${person.name}=====================]=');
//       print(person);
//       print(PersonMap(person));
//       print(jsonEncode(toMap(person)));
//       print(YAMLWriter().write(toMap(person)));
//       expect(toMap(person), PersonMap(person));
//     });
//
//     test('BobSmith()', () {
//       var person = BobSmith();
//       print('========================${person.name}=====================]=');
//       print(person);
//       print(PersonMap(person));
//       print(jsonEncode(toMap(person)));
//       print(YAMLWriter().write(toMap(person)));
//       expect(toMap(person), PersonMap(person));
//     });
//   });
// }
//
// class BobSmith extends Person {
//   BobSmith()
//       : super(
//           name: 'Bob Smith',
//           dateOfBirth: DateTime(1974, 1, 21),
//           children: [MikeSmith(), JaneSmith()],
//         ) {
//     hobby = 'Cooking';
//     gender = Gender.male;
//   }
// }
//
// class MikeSmith extends Person {
//   MikeSmith()
//       : super(
//           name: 'Mike Smith',
//           dateOfBirth: DateTime(2003, 10, 19),
//         ) {
//     gender = Gender.male;
//   }
// }
//
// class PersonMap extends DelegatingMap<String, dynamic> {
//   PersonMap(Person person)
//       : super({
//           'name': person.name,
//           'dateOfBirth': person.dateOfBirth.toIso8601String(),
//           'children': person.children.map((person) => toMap(person)).toList(),
//           'hobby': person.hobby,
//           'gender': person.gender.name
//         });
// }
//
// class JaneSmith extends Person {
//   JaneSmith() : super(name: 'Jane Smith', dateOfBirth: DateTime(2006, 3, 2)) {
//     gender = Gender.female;
//   }
// }
