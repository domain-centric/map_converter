// ignore_for_file: avoid_relative_lib_imports

import 'package:collection/collection.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/person/person.dart';
import '../../../example/lib/type/map.dart';
import '../../../example/lib/type/map_map_converter.dart';

void main() {
  group('mapToExample should convert map to Example object correctly', () {
    final johnMap = {
      'name': 'John',
      'dateOfBirth': DateTime(2003, 03, 01).toIso8601String(),
      'children': [],
      'hobby': 'gaming',
      'gender': 'male'
    };
    final aliceMap = {
      'name': 'Alice',
      'dateOfBirth': DateTime(2002, 02, 03).toIso8601String(),
      'children': [],
      'hobby': 'reading',
      'gender': 'female'
    };

    final exampleMap = {
      'mapWithPrimitiveKeyAndPrimitiveValue': {'1': 2},
      'nullableMapWithPrimitiveKeyAndPrimitiveValue': {3: true},
      'mapWithPrimitiveKeyAndPrimitiveNullableValue': {4.3: 'test'},
      'mapWithComplexKeyAndPrimitiveValue': {johnMap: 5},
      'mapWithComplexNullableKeyAndPrimitiveValue': {null: 6},
      'mapWithPrimitiveKeyAndComplexValue': {7: johnMap},
      'mapWithPrimitiveKeyAndComplexNullableValue': {8: null},
      'mapWithPrimitiveKeyAndListValue': {
        9: [aliceMap, johnMap]
      },
      'mapWithPrimitiveKeyAndNullableListValue': {
        10: Gender.values.map((enumValue) => enumValue.name)
      },
      'mapWithPrimitiveKeyAndMapValue': {
        11: {12: johnMap}
      },
      'mapWithPrimitiveKeyAndNullableMapValue': {
        13: {14: 'female'}
      }
    };

    final example = mapToExample(exampleMap);

    group('Primitive Key and Primitive Value', () {
      test('mapWithPrimitiveKeyAndPrimitiveValue', () {
        example.mapWithPrimitiveKeyAndPrimitiveValue.should.be({'1': 2});
      });
      test('nullableMapWithPrimitiveKeyAndPrimitiveValue', () {
        MapEquality()
            .equals(
                example.nullableMapWithPrimitiveKeyAndPrimitiveValue, {3: true})
            .should
            .beTrue();
      });
      test('mapWithPrimitiveKeyAndPrimitiveNullableValue', () {
        example.mapWithPrimitiveKeyAndPrimitiveNullableValue.should
            .be({4.3: 'test'});
      });
    });
// FIXME:
    // group('Complex Key and Primitive Value', () {
    //   test('mapWithComplexKeyAndPrimitiveValue', () {
    //     example.mapWithComplexKeyAndPrimitiveValue.keys.first.name.should
    //         .be('John');
    //     example.mapWithComplexKeyAndPrimitiveValue.values.first.should.be(5);
    //   });
    //   test('mapWithComplexNullableKeyAndPrimitiveValue', () {
    //     example.mapWithComplexNullableKeyAndPrimitiveValue.keys.first.should
    //         .beNull();
    //     example.mapWithComplexNullableKeyAndPrimitiveValue.values.first.should
    //         .be(6);
    //   });
    // });

    group('Primitive Key and Complex Value', () {
      test('mapWithPrimitiveKeyAndComplexValue', () {
        example.mapWithPrimitiveKeyAndComplexValue.keys.first.should.be(7);
        example.mapWithPrimitiveKeyAndComplexValue.values.first.name.should
            .be('John');
      });
      test('mapWithPrimitiveKeyAndComplexNullableValue', () {
        example.mapWithPrimitiveKeyAndComplexNullableValue.keys.first.should
            .be(8);
        example.mapWithPrimitiveKeyAndComplexNullableValue.values.first.should
            .beNull();
      });
    });

    group('Primitive Key and List Value', () {
      test('mapWithPrimitiveKeyAndListValue', () {
        example.mapWithPrimitiveKeyAndListValue.keys.first.should.be(9);
        example.mapWithPrimitiveKeyAndListValue.values.first.first.name.should
            .be('Alice');
      });
      test('mapWithPrimitiveKeyAndNullableListValue', () {
        example.mapWithPrimitiveKeyAndNullableListValue.keys.first.should
            .be(10);
        example.mapWithPrimitiveKeyAndNullableListValue.values.first!.first.name
            .should
            .be('male');
      });
    });

    group('Primitive Key and Map Value', () {
      test('mapWithPrimitiveKeyAndMapValue', () {
        example.mapWithPrimitiveKeyAndMapValue.keys.first.should.be(11);
        example.mapWithPrimitiveKeyAndMapValue.values.first.keys.first.should
            .be(12);
        example.mapWithPrimitiveKeyAndMapValue.values.first.values.first!.name
            .should
            .be('John');
      });
      test('mapWithPrimitiveKeyAndNullableMapValue', () {
        example.mapWithPrimitiveKeyAndNullableMapValue.keys.first.should.be(13);
        example.mapWithPrimitiveKeyAndNullableMapValue.values.first!.keys.first
            .should
            .be(14);
        example.mapWithPrimitiveKeyAndNullableMapValue.values.first!.values
            .first.name.should
            .be('female');
      });
    });
  });

  group('exampleToMap should convert Example object to map correctly', () {
    final john = Person('John', dateOfBirth: DateTime(2003, 03, 01));
    final alice = Person('Alice', dateOfBirth: DateTime(2002, 02, 03));

    final example = Example()
      ..mapWithPrimitiveKeyAndPrimitiveValue = {'1': 2}
      ..nullableMapWithPrimitiveKeyAndPrimitiveValue = {3: true}
      ..mapWithPrimitiveKeyAndPrimitiveNullableValue = {4.3: 'test'}
      // ..mapWithComplexKeyAndPrimitiveValue = {john: 5}
      // ..mapWithComplexNullableKeyAndPrimitiveValue = {null: 6}
      ..mapWithPrimitiveKeyAndComplexValue = {7: john}
      ..mapWithPrimitiveKeyAndComplexNullableValue = {8: null}
      ..mapWithPrimitiveKeyAndListValue = {
        9: [alice, john]
      }
      ..mapWithPrimitiveKeyAndNullableListValue = {10: Gender.values.toList()}
      ..mapWithPrimitiveKeyAndMapValue = {
        11: {12: john}
      }
      ..mapWithPrimitiveKeyAndNullableMapValue = {
        13: {14: Gender.female}
      };

    final exampleMap = exampleToMap(example);

    group('Primitive Key and Primitive Value', () {
      test('mapWithPrimitiveKeyAndPrimitiveValue', () {
        (exampleMap['mapWithPrimitiveKeyAndPrimitiveValue'] as Map)
            .should
            .be({'1': 2});
      });
      test('nullableMapWithPrimitiveKeyAndPrimitiveValue', () {
        (exampleMap['nullableMapWithPrimitiveKeyAndPrimitiveValue'] as Map)
            .should
            .be({3: true});
      });
      test('mapWithPrimitiveKeyAndPrimitiveNullableValue', () {
        (exampleMap['mapWithPrimitiveKeyAndPrimitiveNullableValue'] as Map)
            .should
            .be({4.3: 'test'});
      });
    });

    // group('Complex Key and Primitive Value', () {
    //   test('mapWithComplexKeyAndPrimitiveValue', () {
    //     final example = Example()
    //       ..mapWithComplexKeyAndPrimitiveValue = {
    //         Person('John', dateOfBirth: DateTime(2003, 02, 25, 12, 34)): 5
    //       };
    //     final exampleMap = exampleToMap(example);
    //     exampleMap['mapWithComplexKeyAndPrimitiveValue']
    //         .keys
    //         .first['name']
    //         .should
    //         .be('John');
    //     exampleMap['mapWithComplexKeyAndPrimitiveValue']
    //         .values
    //         .first
    //         .should
    //         .be(5);
    //   });
    //   test('mapWithComplexNullableKeyAndPrimitiveValue', () {
    //     final example = Example()
    //       ..mapWithComplexNullableKeyAndPrimitiveValue = {null: 6};
    //     final exampleMap = exampleToMap(example);
    //     exampleMap['mapWithComplexNullableKeyAndPrimitiveValue']
    //         .keys
    //         .first
    //         .should
    //         .be(null);
    //     exampleMap['mapWithComplexNullableKeyAndPrimitiveValue']
    //         .values
    //         .first
    //         .should
    //         .be(6);
    //   });
    // });

    group('Primitive Key and Complex Value', () {
      test('mapWithPrimitiveKeyAndComplexValue', () {
        (exampleMap['mapWithPrimitiveKeyAndComplexValue'].keys.first as int)
            .should
            .be(7);
        (exampleMap['mapWithPrimitiveKeyAndComplexValue'].values.first['name']
                as String)
            .should
            .be('John');
      });
      test('mapWithPrimitiveKeyAndComplexNullableValue', () {
        (exampleMap['mapWithPrimitiveKeyAndComplexNullableValue'].keys.first
                as int)
            .should
            .be(8);
        (exampleMap['mapWithPrimitiveKeyAndComplexNullableValue'].values.first
                as Object?)
            .should
            .beNull();
      });
    });

    group('Primitive Key and List Value', () {
      test('mapWithPrimitiveKeyAndListValue', () {
        (exampleMap['mapWithPrimitiveKeyAndListValue'].keys.first as int)
            .should
            .be(9);
        (exampleMap['mapWithPrimitiveKeyAndListValue']
                .values
                .first
                .first['name'] as String)
            .should
            .be('Alice');
      });
      test('mapWithPrimitiveKeyAndNullableListValue', () {
        (exampleMap['mapWithPrimitiveKeyAndNullableListValue'].keys.first
                as int)
            .should
            .be(10);
        (exampleMap['mapWithPrimitiveKeyAndNullableListValue']
                .values
                .first
                .first as String)
            .should
            .be('male');
      });
    });

    group('Primitive Key and Map Value', () {
      test('mapWithPrimitiveKeyAndMapValue', () {
        (exampleMap['mapWithPrimitiveKeyAndMapValue'].keys.first as int)
            .should
            .be(11);
        (exampleMap['mapWithPrimitiveKeyAndMapValue'].values.first.keys.first
                as int)
            .should
            .be(12);
        ((exampleMap['mapWithPrimitiveKeyAndMapValue'] as Map)
                .values
                .first
                .values
                .first['name'] as String)
            .should
            .be('John');
      });
      test('mapWithPrimitiveKeyAndNullableMapValue', () {
        ((exampleMap['mapWithPrimitiveKeyAndNullableMapValue'] as Map)
                .keys
                .first as int)
            .should
            .be(13);
        ((exampleMap['mapWithPrimitiveKeyAndNullableMapValue'] as Map)
                .values
                .first
                .keys
                .first as int)
            .should
            .be(14);
        ((exampleMap['mapWithPrimitiveKeyAndNullableMapValue'] as Map)
                .values
                .first
                .values
                .first as String)
            .should
            .be('female');
      });
    });
  });
}
