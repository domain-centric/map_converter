import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/object.dart';
import '../../../example/lib/type/object_map_converter.dart';
import '../person/person_map_converter_test.dart';

final object = JaneSmith();
final objectMap = PersonMap(object);
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myObject should be correct', () {
      final exampleMap = {'myPerson': objectMap};
      final example = exampleMapper.fromMap(exampleMap);
      example.myPerson.toString().should.be(object.toString());
    });
    test('myNullableObject should be correct', () {
      final exampleMap = {
        'myPerson': objectMap,
        'myNullablePerson': objectMap,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullablePerson.toString().should.be(object.toString());
    });
    test('myNullableObject with null should be correct', () {
      final exampleMap = {
        'myPerson': objectMap,
        'myNullablePerson': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullablePerson.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myObject should be correct', () {
      final example = Example()
        ..myPerson = object
        ..myNullablePerson = null;
      final exampleMap = exampleMapper.toMap(example);
      exampleMap['myPerson'].toString().should.be(objectMap.toString());
    });
    test('myNullableObject should be correct', () {
      final example = Example()
        ..myPerson = object
        ..myNullablePerson = object;
      final exampleMap = exampleMapper.toMap(example);
      exampleMap['myNullablePerson'].toString().should.be(objectMap.toString());
    });
    test('myNullableObject with null should be correct', () {
      final example = Example()
        ..myPerson = object
        ..myNullablePerson = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullablePerson'] as Map?).should.beNull();
    });
  });
}
