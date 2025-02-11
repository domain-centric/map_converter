import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/string.dart';
import '../../../example/lib/type/string_map_converter.dart';

const helloWorld = 'Hello World';
void main() {
  group('mapToExample', () {
    test('myString should be correct', () {
      final exampleMap = {'myString': helloWorld};
      final example = mapToExample(exampleMap);
      example.myString.should.be(helloWorld);
    });
    test('myNullableString should be correct', () {
      final exampleMap = {
        'myString': helloWorld,
        'myNullableString': helloWorld,
      };
      final example = mapToExample(exampleMap);
      example.myNullableString.should.be(helloWorld);
    });
    test('myNullableString with null should be correct', () {
      final exampleMap = {
        'myString': helloWorld,
        'myNullableString': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableString.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myString should be correct', () {
      final example = Example()
        ..myString = helloWorld
        ..myNullableString = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myString'] as String).should.be(helloWorld);
    });
    test('myNullableString should be correct', () {
      final example = Example()
        ..myString = helloWorld
        ..myNullableString = helloWorld;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableString'] as String?).should.be(helloWorld);
    });
    test('myNullableString with null should be correct', () {
      final example = Example()
        ..myString = helloWorld
        ..myNullableString = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableString'] as String?).should.beNull();
    });
  });
}
