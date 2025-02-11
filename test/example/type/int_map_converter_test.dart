import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/int.dart';
import '../../../example/lib/type/int_map_converter.dart';

const intValue = 3;
void main() {
  group('mapToExample', () {
    test('myInt should be correct', () {
      final exampleMap = {'myInt': intValue};
      final example = mapToExample(exampleMap);
      example.myInt.should.be(intValue);
    });
    test('myNullableInt should be correct', () {
      final exampleMap = {
        'myInt': intValue,
        'myNullableInt': intValue,
      };
      final example = mapToExample(exampleMap);
      example.myNullableInt.should.be(intValue);
    });
    test('myNullableInt with null should be correct', () {
      final exampleMap = {
        'myInt': intValue,
        'myNullableInt': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableInt.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myInt should be correct', () {
      final example = Example()
        ..myInt = intValue
        ..myNullableInt = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myInt'] as num).should.be(intValue);
    });
    test('myNullableInt should be correct', () {
      final example = Example()
        ..myInt = intValue
        ..myNullableInt = intValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableInt'] as num?).should.be(intValue);
    });
    test('myNullableInt with null should be correct', () {
      final example = Example()
        ..myInt = intValue
        ..myNullableInt = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableInt'] as num?).should.beNull();
    });
  });
}
