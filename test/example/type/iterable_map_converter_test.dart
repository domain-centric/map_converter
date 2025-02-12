import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';
import '../../../example/lib/person/person_map_converter.dart';
import '../../../example/lib/type/iterable.dart';
import '../../../example/lib/type/iterable_map_converter.dart';
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
      'iterableOfBool': [true, false],
      'iterableOfGender': {'male', 'female'},
      'iterableOfPerson': {
        johnMap,
        saraMap,
      },
      'iterableOfNullableInt': [1, null, 3],
      'nullableIterableOfDouble': [1.1, 2.2, 3.3],
      'nullableIterableOfNullableStrings': ['a', null, 'c']
    };

    final example = mapToExample(exampleMap);

    test('iterableOfBool should be correct', () {
      example.iterableOfBool.should.be({true, false});
    });
    test('iterableOfGender should be correct', () {
      example.iterableOfGender.should.be({Gender.male, Gender.female});
    });
    test('iterableOfPerson length should be correct', () {
      example.iterableOfPerson.length.should.be(2);
    });
    test('iterableOfNullableInt should be correct', () {
      example.iterableOfNullableInt.should.be({1, null, 3});
    });
    test('nullableIterableOfDouble should be correct', () {
      example.nullableIterableOfDouble.should.be({1.1, 2.2, 3.3});
    });
    test('nullableIterableOfNullableStrings should be correct', () {
      example.nullableIterableOfNullableStrings.should.be({'a', null, 'c'});
    });
  });

  group('exampleToMap', () {
    final example = Example()
      ..iterableOfBool = {true, false}
      ..iterableOfGender = {Gender.male, Gender.female}
      ..iterableOfPerson = {
        john,
        sara,
      }
      ..iterableOfNullableInt = {1, null, 3}
      ..nullableIterableOfDouble = {1.1, 2.2, 3.3}
      ..nullableIterableOfNullableStrings = {'a', null, 'c'};

    final exampleMap = exampleToMap(example);

    test('iterableOfBool should be correct', () {
      (exampleMap['iterableOfBool'] as Iterable).should.be({true, false});
    });
    test('iterableOfGender should be correct', () {
      (exampleMap['iterableOfGender'] as Iterable)
          .should
          .be({'male', 'female'});
    });
    test('iterableOfPerson should be correct', () {
      exampleMap['iterableOfPerson']
          .toString()
          .should
          .be([johnMap, saraMap].toString());
    });
    test('iterableOfNullableInt should be correct', () {
      (exampleMap['iterableOfNullableInt'] as Iterable).should.be({1, null, 3});
    });
    test('nullableIterableOfDouble should be correct', () {
      (exampleMap['nullableIterableOfDouble'] as Iterable)
          .should
          .be({1.1, 2.2, 3.3});
    });
    test('nullableIterableOfNullableStrings should be correct', () {
      (exampleMap['nullableIterableOfNullableStrings'] as Iterable)
          .should
          .be({'a', null, 'c'});
    });
  });
}
