import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/bool.dart';
import '../../../example/lib/type/bool_map_converter.dart';

const boolValue = true;
void main() {
  group('mapToExample', () {
    test('myBool should be correct', () {
      final exampleMap = {'myBool': boolValue};
      final example = mapToExample(exampleMap);
      example.myBool.should.be(boolValue);
    });
    test('myNullableBool should be correct', () {
      final exampleMap = {
        'myBool': boolValue,
        'myNullableBool': boolValue,
      };
      final example = mapToExample(exampleMap);
      example.myNullableBool.should.be(boolValue);
    });
    test('myNullableBool with null should be correct', () {
      final exampleMap = {
        'myBool': boolValue,
        'myNullableBool': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableBool.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myBool should be correct', () {
      final example = Example()
        ..myBool = boolValue
        ..myNullableBool = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myBool'] as bool).should.be(boolValue);
    });
    test('myNullableBool should be correct', () {
      final example = Example()
        ..myBool = boolValue
        ..myNullableBool = boolValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableBool'] as bool?).should.be(boolValue);
    });
    test('myNullableBool with null should be correct', () {
      final example = Example()
        ..myBool = boolValue
        ..myNullableBool = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableBool'] as bool?).should.beNull();
    });
  });
}
