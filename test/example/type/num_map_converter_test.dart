import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/num.dart';
import '../../../example/lib/type/num_map_converter.dart';

const numberValue = 3.2; // could be double or int
void main() {
  group('mapToExample', () {
    test('myNum should be correct', () {
      final exampleMap = {'myNum': numberValue};
      final example = mapToExample(exampleMap);
      example.myNum.should.be(numberValue);
    });
    test('myNullableNum should be correct', () {
      final exampleMap = {
        'myNum': numberValue,
        'myNullableNum': numberValue,
      };
      final example = mapToExample(exampleMap);
      example.myNullableNum.should.be(numberValue);
    });
    test('myNullableNum with null should be correct', () {
      final exampleMap = {
        'myNum': numberValue,
        'myNullableNum': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableNum.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myNum should be correct', () {
      final example = Example()
        ..myNum = numberValue
        ..myNullableNum = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNum'] as num).should.be(numberValue);
    });
    test('myNullableNum should be correct', () {
      final example = Example()
        ..myNum = numberValue
        ..myNullableNum = numberValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableNum'] as num?).should.be(numberValue);
    });
    test('myNullableNum with null should be correct', () {
      final example = Example()
        ..myNum = numberValue
        ..myNullableNum = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableNum'] as num?).should.beNull();
    });
  });
}
