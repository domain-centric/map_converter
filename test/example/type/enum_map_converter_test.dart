import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/bool.dart';
import '../../../example/lib/type/bool.mapper.dart';

const boolValue = true;
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myBool should be correct', () {
      final exampleMap = {'myBool': boolValue};
      final example = exampleMapper.fromMap(exampleMap);
      example.myBool.should.be(boolValue);
    });
    test('myNullableBool should be correct', () {
      final exampleMap = {
        'myBool': boolValue,
        'myNullableBool': boolValue,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableBool.should.be(boolValue);
    });
    test('myNullableBool with null should be correct', () {
      final exampleMap = {
        'myBool': boolValue,
        'myNullableBool': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableBool.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myBool should be correct', () {
      final example = Example()
        ..myBool = boolValue
        ..myNullableBool = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myBool'] as bool).should.be(boolValue);
    });
    test('myNullableBool should be correct', () {
      final example = Example()
        ..myBool = boolValue
        ..myNullableBool = boolValue;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableBool'] as bool?).should.be(boolValue);
    });
    test('myNullableBool with null should be correct', () {
      final example = Example()
        ..myBool = boolValue
        ..myNullableBool = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableBool'] as bool?).should.beNull();
    });
  });
}
