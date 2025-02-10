import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';
import '../../../example/lib/person/person_map_converter.dart';
import '../../../example/lib/type/list.dart';
import '../../../example/lib/type/list_map_converter.dart';
import '../../../example/lib/person/person.dart';

void main() {
  group('mapToExample', () {
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
    final exampleMap = {
      'boolList': [true, false],
      'boolListWithNullableBools': [true, null, false],
      'nullableBoolList': null,
      'nullableBoolListWithNullableBools': [true, null, false],
      'numList': [1, 2.5],
      'nullableNumList': [1, null, 2.5],
      'intList': [1, 2],
      'nullableIntList': [1, null, 2],
      'doubleList': [1.1, 2.2],
      'nullableDoubleList': [1.1, null, 2.2],
      'stringList': ['a', 'b'],
      'nullableStringList': ['a', null, 'b'],
      'uriList': ['https://example.com', 'https://example.org'],
      'nullableUriList': ['https://example.com', null, 'https://example.org'],
      'bigIntList': ['12345678901234567890', '98765432109876543210'],
      'nullableBigIntList': [
        '12345678901234567890',
        null,
        '98765432109876543210'
      ],
      'dateTimeList': ['2023-01-01T00:00:00.000Z', '2023-12-31T23:59:59.999Z'],
      'nullableDateTimeList': [
        '2023-01-01T00:00:00.000Z',
        null,
        '2023-12-31T23:59:59.999Z'
      ],
      'durationList': [1000, 2000],
      'nullableDurationList': [1000, null, 2000],
      'genderList': ['male', 'female'],
      'nullableGenderList': ['male', null, 'female'],
      'personList': [johnMap, saraMap],
      'nullablePersonList': [johnMap, null],
    };

    final example = mapToExample(exampleMap);

    group('boolList', () {
      test('should convert boolList', () {
        example.boolList.should.be([true, false]);
      });
      test('should convert boolListWithNullableBools', () {
        example.boolListWithNullableBools.should.be([true, null, false]);
      });
      test('should convert nullableBoolList', () {
        example.nullableBoolList.should.beNull();
      });
      test('should convert nullableBoolListWithNullableBools', () {
        example.nullableBoolListWithNullableBools.should
            .be([true, null, false]);
      });
    });

    group('numList', () {
      test('should convert numList', () {
        example.numList.should.be([1, 2.5]);
      });
      test('should convert nullableNumList', () {
        example.nullableNumList.should.be([1, null, 2.5]);
      });
    });

    group('intList', () {
      test('should convert intList', () {
        example.intList.should.be([1, 2]);
      });
      test('should convert nullableIntList', () {
        example.nullableIntList.should.be([1, null, 2]);
      });
    });

    group('doubleList', () {
      test('should convert doubleList', () {
        example.doubleList.should.be([1.1, 2.2]);
      });
      test('should convert nullableDoubleList', () {
        example.nullableDoubleList.should.be([1.1, null, 2.2]);
      });
    });

    group('stringList', () {
      test('should convert stringList', () {
        example.stringList.should.be(['a', 'b']);
      });
      test('should convert nullableStringList', () {
        example.nullableStringList.should.be(['a', null, 'b']);
      });
    });

    group('uriList', () {
      test('should convert uriList', () {
        example.uriList.should.be([
          Uri.parse('https://example.com'),
          Uri.parse('https://example.org')
        ]);
      });
      test('should convert nullableUriList', () {
        example.nullableUriList.should.be([
          Uri.parse('https://example.com'),
          null,
          Uri.parse('https://example.org')
        ]);
      });
    });

    group('bigIntList', () {
      test('should convert bigIntList', () {
        example.bigIntList.should.be([
          BigInt.parse('12345678901234567890'),
          BigInt.parse('98765432109876543210')
        ]);
      });
      test('should convert nullableBigIntList', () {
        example.nullableBigIntList.should.be([
          BigInt.parse('12345678901234567890'),
          null,
          BigInt.parse('98765432109876543210')
        ]);
      });
    });

    group('dateTimeList', () {
      test('should convert dateTimeList', () {
        example.dateTimeList.should.be([
          DateTime.parse('2023-01-01T00:00:00.000Z'),
          DateTime.parse('2023-12-31T23:59:59.999Z')
        ]);
      });
      test('should convert nullableDateTimeList', () {
        example.nullableDateTimeList.should.be([
          DateTime.parse('2023-01-01T00:00:00.000Z'),
          null,
          DateTime.parse('2023-12-31T23:59:59.999Z')
        ]);
      });
    });

    group('durationList', () {
      test('should convert durationList', () {
        example.durationList.should
            .be([Duration(microseconds: 1000), Duration(microseconds: 2000)]);
      });
      test('should convert nullableDurationList', () {
        example.nullableDurationList.should.be(
            [Duration(microseconds: 1000), null, Duration(microseconds: 2000)]);
      });
    });

    group('genderList', () {
      test('should convert genderList', () {
        example.genderList.should.be([Gender.male, Gender.female]);
      });
      test('should convert nullableGenderList', () {
        example.nullableGenderList.should
            .be([Gender.male, null, Gender.female]);
      });
    });

    group('personList', () {
      test('should convert personList', () {
        example.personList.toString().should.be([
              john,
              sara,
            ].toString());
      });
      test('should convert nullablePersonList', () {
        example.nullablePersonList
            .toString()
            .should
            .be([john, null].toString());
      });
    });
  });
  group('exampleToMap', () {
    final john = Person('John',
        dateOfBirth: DateTime(2000, 1, 1),
        children: [],
        hobby: 'gaming',
        gender: Gender.male);
    final sara = Person('Sara',
        dateOfBirth: DateTime(2003, 2, 3),
        children: [],
        hobby: 'reading',
        gender: Gender.female);
    final example = Example()
      ..boolList = [true, false]
      ..boolListWithNullableBools = [true, null, false]
      ..nullableBoolList = null
      ..nullableBoolListWithNullableBools = [true, null, false]
      ..numList = [1, 2.5]
      ..nullableNumList = [1, null, 2.5]
      ..intList = [1, 2]
      ..nullableIntList = [1, null, 2]
      ..doubleList = [1.1, 2.2]
      ..nullableDoubleList = [1.1, null, 2.2]
      ..stringList = ['a', 'b']
      ..nullableStringList = ['a', null, 'b']
      ..uriList = [
        Uri.parse('https://example.com'),
        Uri.parse('https://example.org')
      ]
      ..nullableUriList = [
        Uri.parse('https://example.com'),
        null,
        Uri.parse('https://example.org')
      ]
      ..bigIntList = [
        BigInt.parse('12345678901234567890'),
        BigInt.parse('98765432109876543210')
      ]
      ..nullableBigIntList = [
        BigInt.parse('12345678901234567890'),
        null,
        BigInt.parse('98765432109876543210')
      ]
      ..dateTimeList = [
        DateTime.parse('2023-01-01T00:00:00.000Z'),
        DateTime.parse('2023-12-31T23:59:59.999Z')
      ]
      ..nullableDateTimeList = [
        DateTime.parse('2023-01-01T00:00:00.000Z'),
        null,
        DateTime.parse('2023-12-31T23:59:59.999Z')
      ]
      ..durationList = [
        Duration(microseconds: 1000),
        Duration(microseconds: 2000)
      ]
      ..nullableDurationList = [
        Duration(microseconds: 1000),
        null,
        Duration(microseconds: 2000)
      ]
      ..genderList = [Gender.male, Gender.female]
      ..nullableGenderList = [Gender.male, null, Gender.female]
      ..personList = [john, sara]
      ..nullablePersonList = [john, null];

    final exampleMap = exampleToMap(example);

    group('boolList', () {
      test('should convert boolList', () {
        (exampleMap['boolList'] as List).should.be([true, false]);
      });
      test('should convert boolListWithNullableBools', () {
        (exampleMap['boolListWithNullableBools'] as List)
            .should
            .be([true, null, false]);
      });
      test('should convert nullableBoolList', () {
        (exampleMap['nullableBoolList'] as Object?).should.beNull();
      });
      test('should convert nullableBoolListWithNullableBools', () {
        (exampleMap['nullableBoolListWithNullableBools'] as List)
            .should
            .be([true, null, false]);
      });
    });

    group('numList', () {
      test('should convert numList', () {
        (exampleMap['numList'] as List).should.be([1, 2.5]);
      });
      test('should convert nullableNumList', () {
        (exampleMap['nullableNumList'] as List).should.be([1, null, 2.5]);
      });
    });

    group('intList', () {
      test('should convert intList', () {
        (exampleMap['intList'] as List).should.be([1, 2]);
      });
      test('should convert nullableIntList', () {
        (exampleMap['nullableIntList'] as List).should.be([1, null, 2]);
      });
    });

    group('doubleList', () {
      test('should convert doubleList', () {
        (exampleMap['doubleList'] as List).should.be([1.1, 2.2]);
      });
      test('should convert nullableDoubleList', () {
        (exampleMap['nullableDoubleList'] as List).should.be([1.1, null, 2.2]);
      });
    });

    group('stringList', () {
      test('should convert stringList', () {
        (exampleMap['stringList'] as List).should.be(['a', 'b']);
      });
      test('should convert nullableStringList', () {
        (exampleMap['nullableStringList'] as List).should.be(['a', null, 'b']);
      });
    });

    group('uriList', () {
      test('should convert uriList', () {
        (exampleMap['uriList'] as List)
            .should
            .be(['https://example.com', 'https://example.org']);
      });
      test('should convert nullableUriList', () {
        (exampleMap['nullableUriList'] as List)
            .should
            .be(['https://example.com', null, 'https://example.org']);
      });
    });

    group('bigIntList', () {
      test('should convert bigIntList', () {
        (exampleMap['bigIntList'] as List)
            .should
            .be(['12345678901234567890', '98765432109876543210']);
      });
      test('should convert nullableBigIntList', () {
        (exampleMap['nullableBigIntList'] as List)
            .should
            .be(['12345678901234567890', null, '98765432109876543210']);
      });
    });

    group('dateTimeList', () {
      test('should convert dateTimeList', () {
        (exampleMap['dateTimeList'] as List)
            .should
            .be(['2023-01-01T00:00:00.000Z', '2023-12-31T23:59:59.999Z']);
      });
      test('should convert nullableDateTimeList', () {
        (exampleMap['nullableDateTimeList'] as List)
            .should
            .be(['2023-01-01T00:00:00.000Z', null, '2023-12-31T23:59:59.999Z']);
      });
    });

    group('durationList', () {
      test('should convert durationList', () {
        (exampleMap['durationList'] as List).should.be([1000, 2000]);
      });
      test('should convert nullableDurationList', () {
        (exampleMap['nullableDurationList'] as List)
            .should
            .be([1000, null, 2000]);
      });
    });

    group('genderList', () {
      test('should convert genderList', () {
        (exampleMap['genderList'] as List).should.be(['male', 'female']);
      });
      test('should convert nullableGenderList', () {
        (exampleMap['nullableGenderList'] as List)
            .should
            .be(['male', null, 'female']);
      });
    });

    group('personList', () {
      test('should convert personList', () {
        exampleMap['personList']
            .toString()
            .should
            .be([personToMap(john), personToMap(sara)].toString());
      });
      test('should convert nullablePersonList', () {
        exampleMap['nullablePersonList']
            .toString()
            .should
            .be([personToMap(john), null].toString());
      });
    });
  });
}
