import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';
import '../../../example/lib/person/person_map_converter.dart';
import '../../../example/lib/type/set.dart';
import '../../../example/lib/type/set_map_converter.dart';
import '../../../example/lib/person/person.dart';

void main() {
  final john = Person('John',
      dateOfBirth: DateTime(2000, 1, 1),
      children: [],
      hobby: 'gaming',
      gender: Gender.male);
  final johnMap = personToMap(john);
  final sara = Person('Sara',
      dateOfBirth: DateTime(2003, 2, 3),
      children: [],
      hobby: 'reading',
      gender: Gender.female);
  final saraMap = personToMap(sara);
  group('mapToExample', () {
    final exampleMap = {
      'setOfBool': {true, false},
      'setOfGender': {'male', 'female'},
      'setOfPerson': {
        johnMap,
        saraMap,
      },
      'setOfNullableInt': [1, null, 3],
      'nullableSetOfDouble': [1.1, 2.2, 3.3],
      'nullableSetOfNullableStrings': ['a', null, 'c']
    };

    final example = mapToExample(exampleMap);

    test('setOfBool should be correct', () {
      example.setOfBool.should.be({true, false});
    });
    test('setOfGender should be correct', () {
      example.setOfGender.should.be({Gender.male, Gender.female});
    });
    test('setOfPerson length should be correct', () {
      example.setOfPerson.length.should.be(2);
    });
    test('setOfNullableInt should be correct', () {
      example.setOfNullableInt.should.be({1, null, 3});
    });
    test('nullableSetOfDouble should be correct', () {
      example.nullableSetOfDouble.should.be({1.1, 2.2, 3.3});
    });
    test('nullableSetOfNullableStrings should be correct', () {
      example.nullableSetOfNullableStrings.should.be({'a', null, 'c'});
    });
  });

  group('exampleToMap', () {
    final example = Example()
      ..setOfBool = {true, false}
      ..setOfGender = {Gender.male, Gender.female}
      ..setOfPerson = {
        john,
        sara,
      }
      ..setOfNullableInt = {1, null, 3}
      ..nullableSetOfDouble = {1.1, 2.2, 3.3}
      ..nullableSetOfNullableStrings = {'a', null, 'c'};

    final exampleMap = exampleToMap(example);

    test('setOfBool should be correct', () {
      (exampleMap['setOfBool'] as Set).should.be({true, false});
    });
    test('setOfGender should be correct', () {
      (exampleMap['setOfGender'] as Set).should.be({'male', 'female'});
    });
    test('setOfPerson should be correct', () {
      exampleMap['setOfPerson']
          .toString()
          .should
          .be({johnMap, saraMap}.toString());
    });
    test('setOfNullableInt should be correct', () {
      (exampleMap['setOfNullableInt'] as Set).should.be({1, null, 3});
    });
    test('nullableSetOfDouble should be correct', () {
      (exampleMap['nullableSetOfDouble'] as Set).should.be({1.1, 2.2, 3.3});
    });
    test('nullableSetOfNullableStrings should be correct', () {
      (exampleMap['nullableSetOfNullableStrings'] as Set)
          .should
          .be({'a', null, 'c'});
    });
  });
}
