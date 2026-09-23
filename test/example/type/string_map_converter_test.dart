import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/string.dart';
import '../../../example/lib/type/string_map_converter.dart';

const helloWorld = 'Hello World';
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myString should be correct', () {
      final exampleMap = {'myString': helloWorld};
      final example = exampleMapper.fromMap(exampleMap);
      example.myString.should.be(helloWorld);
    });
    test('myNullableString should be correct', () {
      final exampleMap = {
        'myString': helloWorld,
        'myNullableString': helloWorld,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableString.should.be(helloWorld);
    });
    test('myNullableString with null should be correct', () {
      final exampleMap = {
        'myString': helloWorld,
        'myNullableString': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableString.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myString should be correct', () {
      final example = Example()
        ..myString = helloWorld
        ..myNullableString = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myString'] as String).should.be(helloWorld);
    });
    test('myNullableString should be correct', () {
      final example = Example()
        ..myString = helloWorld
        ..myNullableString = helloWorld;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableString'] as String?).should.be(helloWorld);
    });
    test('myNullableString with null should be correct', () {
      final example = Example()
        ..myString = helloWorld
        ..myNullableString = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableString'] as String?).should.beNull();
    });
  });
}
