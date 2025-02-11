import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/string.dart';
import '../../../example/lib/type/string_map_converter.dart';

const helloWorld = 'Hello World';
void main() {
  group('mapToExample', () {
    test('string should be correct', () {
      final exampleMap = {'string': helloWorld};
      final example = mapToExample(exampleMap);
      example.string.should.be(helloWorld);
    });
    test('nullableString should be correct', () {
      var helloWorld = 'Hello World';
      final exampleMap = {
        'string': helloWorld,
        'nullableString': helloWorld,
      };
      final example = mapToExample(exampleMap);
      example.nullableString.should.be(helloWorld);
    });
    test('nullableString with null should be correct', () {
      final exampleMap = {
        'string': helloWorld,
        'nullableString': null,
      };
      final example = mapToExample(exampleMap);
      example.nullableString.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('string should be correct', () {
      final example = Example()
        ..string = helloWorld
        ..nullableString = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['string'] as String).should.be(helloWorld);
    });
    test('nullableString should be correct', () {
      final example = Example()
        ..string = helloWorld
        ..nullableString = helloWorld;
      final exampleMap = exampleToMap(example);
      (exampleMap['nullableString'] as String?).should.be(helloWorld);
    });
    test('nullableString with null should be correct', () {
      final example = Example()
        ..string = helloWorld
        ..nullableString = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['nullableString'] as String?).should.beNull();
    });
  });
}
