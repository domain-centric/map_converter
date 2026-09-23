import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';
import '../../../example/lib/person/person.mapper.dart';
import '../../../example/lib/type/iterable.dart';
import '../../../example/lib/type/iterable.mapper.dart';
import '../../../example/lib/person/person.dart';

void main() {
  final personMapper = const PersonMapper();
  final john = Person('John',
      dateOfBirth: DateTime(2000, 1, 1),
      children: [],
      hobby: 'gaming',
      gender: Gender.male);
  final johnMap = personMapper.toMap(john);
  final sara = Person('Sara',
      dateOfBirth: DateTime(2003, 2, 3),
      children: [],
      hobby: 'reading',
      gender: Gender.female);
  final saraMap = personMapper.toMap(sara);
  group('exampleMapper.fromMap', () {
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

    final example = const ExampleMapper().fromMap(exampleMap);

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

  group('exampleMapper.toMap', () {
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

    final exampleMap = const ExampleMapper().toMap(example);

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
