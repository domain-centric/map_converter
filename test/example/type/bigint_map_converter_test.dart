import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/bigint.dart';
import '../../../example/lib/type/bigint.mapper.dart';

final bigIntValue = BigInt.from(0x7FFFFFFFFFFFFFFF);
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myBigInt should be correct', () {
      final exampleMap = {'myBigInt': bigIntValue.toString()};
      final example = exampleMapper.fromMap(exampleMap);
      example.myBigInt.should.be(bigIntValue);
    });
    test('myNullableBigInt should be correct', () {
      final exampleMap = {
        'myBigInt': bigIntValue.toString(),
        'myNullableBigInt': bigIntValue.toString(),
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableBigInt.should.be(bigIntValue);
    });
    test('myNullableBigInt with null should be correct', () {
      final exampleMap = {
        'myBigInt': bigIntValue.toString(),
        'myNullableBigInt': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableBigInt.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myBigInt should be correct', () {
      final example = Example()
        ..myBigInt = bigIntValue
        ..myNullableBigInt = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myBigInt'] as String).should.be(bigIntValue.toString());
    });
    test('myNullableBigInt should be correct', () {
      final example = Example()
        ..myBigInt = bigIntValue
        ..myNullableBigInt = bigIntValue;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableBigInt'] as String?)
          .should
          .be(bigIntValue.toString());
    });
    test('myNullableBigInt with null should be correct', () {
      final example = Example()
        ..myBigInt = bigIntValue
        ..myNullableBigInt = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableBigInt'] as String?).should.beNull();
    });
  });
}
