import 'dart:math';

import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/double.dart';
import '../../../example/lib/type/double_map_converter.dart';

const doubleValue = pi;
void main() {
  group('mapToExample', () {
    test('myDouble should be correct', () {
      final exampleMap = {'myDouble': doubleValue};
      final example = mapToExample(exampleMap);
      example.myDouble.should.be(doubleValue);
    });
    test('myNullableDouble should be correct', () {
      final exampleMap = {
        'myDouble': doubleValue,
        'myNullableDouble': doubleValue,
      };
      final example = mapToExample(exampleMap);
      example.myNullableDouble.should.be(doubleValue);
    });
    test('myNullableDouble with null should be correct', () {
      final exampleMap = {
        'myDouble': doubleValue,
        'myNullableDouble': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableDouble.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myDouble should be correct', () {
      final example = Example()
        ..myDouble = doubleValue
        ..myNullableDouble = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myDouble'] as num).should.be(doubleValue);
    });
    test('myNullableDouble should be correct', () {
      final example = Example()
        ..myDouble = doubleValue
        ..myNullableDouble = doubleValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableDouble'] as num?).should.be(doubleValue);
    });
    test('myNullableDouble with null should be correct', () {
      final example = Example()
        ..myDouble = doubleValue
        ..myNullableDouble = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableDouble'] as num?).should.beNull();
    });
  });
}
