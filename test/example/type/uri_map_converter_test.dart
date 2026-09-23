import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/uri.dart';
import '../../../example/lib/type/uri_map_converter.dart';

final uriValue = Uri(scheme: 'https', host: 'dart.dev');
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myUri should be correct', () {
      final exampleMap = {'myUri': uriValue.toString()};
      final example = exampleMapper.fromMap(exampleMap);
      example.myUri.should.be(uriValue);
    });
    test('myNullableUri should be correct', () {
      final exampleMap = {
        'myUri': uriValue.toString(),
        'myNullableUri': uriValue.toString(),
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableUri.should.be(uriValue);
    });
    test('myNullableUri with null should be correct', () {
      final exampleMap = {
        'myUri': uriValue.toString(),
        'myNullableUri': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableUri.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myUri should be correct', () {
      final example = Example()
        ..myUri = uriValue
        ..myNullableUri = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myUri'] as String).should.be(uriValue.toString());
    });
    test('myNullableUri should be correct', () {
      final example = Example()
        ..myUri = uriValue
        ..myNullableUri = uriValue;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableUri'] as String?).should.be(uriValue.toString());
    });
    test('myNullableUri with null should be correct', () {
      final example = Example()
        ..myUri = uriValue
        ..myNullableUri = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableUri'] as String?).should.beNull();
    });
  });
}
