import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/int.dart';
import '../../../example/lib/type/int_map_converter.dart';

const intValue = 3;
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myInt should be correct', () {
      final exampleMap = {'myInt': intValue};
      final example = exampleMapper.fromMap(exampleMap);
      example.myInt.should.be(intValue);
    });
    test('myNullableInt should be correct', () {
      final exampleMap = {
        'myInt': intValue,
        'myNullableInt': intValue,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableInt.should.be(intValue);
    });
    test('myNullableInt with null should be correct', () {
      final exampleMap = {
        'myInt': intValue,
        'myNullableInt': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableInt.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myInt should be correct', () {
      final example = Example()
        ..myInt = intValue
        ..myNullableInt = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myInt'] as num).should.be(intValue);
    });
    test('myNullableInt should be correct', () {
      final example = Example()
        ..myInt = intValue
        ..myNullableInt = intValue;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableInt'] as num?).should.be(intValue);
    });
    test('myNullableInt with null should be correct', () {
      final example = Example()
        ..myInt = intValue
        ..myNullableInt = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableInt'] as num?).should.beNull();
    });
  });
}
