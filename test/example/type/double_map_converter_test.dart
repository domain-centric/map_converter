import 'dart:math';

import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/double.dart';
import '../../../example/lib/type/double.mapper.dart';

const doubleValue = pi;
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myDouble should be correct', () {
      final exampleMap = {'myDouble': doubleValue};
      final example = exampleMapper.fromMap(exampleMap);
      example.myDouble.should.be(doubleValue);
    });
    test('myNullableDouble should be correct', () {
      final exampleMap = {
        'myDouble': doubleValue,
        'myNullableDouble': doubleValue,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableDouble.should.be(doubleValue);
    });
    test('myNullableDouble with null should be correct', () {
      final exampleMap = {
        'myDouble': doubleValue,
        'myNullableDouble': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableDouble.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myDouble should be correct', () {
      final example = Example()
        ..myDouble = doubleValue
        ..myNullableDouble = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myDouble'] as num).should.be(doubleValue);
    });
    test('myNullableDouble should be correct', () {
      final example = Example()
        ..myDouble = doubleValue
        ..myNullableDouble = doubleValue;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableDouble'] as num?).should.be(doubleValue);
    });
    test('myNullableDouble with null should be correct', () {
      final example = Example()
        ..myDouble = doubleValue
        ..myNullableDouble = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableDouble'] as num?).should.beNull();
    });
  });
}
