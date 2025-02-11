import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/bigint.dart';
import '../../../example/lib/type/bigint_map_converter.dart';

final bigIntValue = BigInt.from(0x7FFFFFFFFFFFFFFF);
void main() {
  group('mapToExample', () {
    test('myBigInt should be correct', () {
      final exampleMap = {'myBigInt': bigIntValue.toString()};
      final example = mapToExample(exampleMap);
      example.myBigInt.should.be(bigIntValue);
    });
    test('myNullableBigInt should be correct', () {
      final exampleMap = {
        'myBigInt': bigIntValue.toString(),
        'myNullableBigInt': bigIntValue.toString(),
      };
      final example = mapToExample(exampleMap);
      example.myNullableBigInt.should.be(bigIntValue);
    });
    test('myNullableBigInt with null should be correct', () {
      final exampleMap = {
        'myBigInt': bigIntValue.toString(),
        'myNullableBigInt': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableBigInt.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myBigInt should be correct', () {
      final example = Example()
        ..myBigInt = bigIntValue
        ..myNullableBigInt = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myBigInt'] as String).should.be(bigIntValue.toString());
    });
    test('myNullableBigInt should be correct', () {
      final example = Example()
        ..myBigInt = bigIntValue
        ..myNullableBigInt = bigIntValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableBigInt'] as String?)
          .should
          .be(bigIntValue.toString());
    });
    test('myNullableBigInt with null should be correct', () {
      final example = Example()
        ..myBigInt = bigIntValue
        ..myNullableBigInt = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableBigInt'] as String?).should.beNull();
    });
  });
}
