import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/uri.dart';
import '../../../example/lib/type/uri_map_converter.dart';

final uriValue = Uri(scheme: 'https', host: 'dart.dev');
void main() {
  group('mapToExample', () {
    test('myUri should be correct', () {
      final exampleMap = {'myUri': uriValue.toString()};
      final example = mapToExample(exampleMap);
      example.myUri.should.be(uriValue);
    });
    test('myNullableUri should be correct', () {
      final exampleMap = {
        'myUri': uriValue.toString(),
        'myNullableUri': uriValue.toString(),
      };
      final example = mapToExample(exampleMap);
      example.myNullableUri.should.be(uriValue);
    });
    test('myNullableUri with null should be correct', () {
      final exampleMap = {
        'myUri': uriValue.toString(),
        'myNullableUri': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableUri.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myUri should be correct', () {
      final example = Example()
        ..myUri = uriValue
        ..myNullableUri = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myUri'] as String).should.be(uriValue.toString());
    });
    test('myNullableUri should be correct', () {
      final example = Example()
        ..myUri = uriValue
        ..myNullableUri = uriValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableUri'] as String?).should.be(uriValue.toString());
    });
    test('myNullableUri with null should be correct', () {
      final example = Example()
        ..myUri = uriValue
        ..myNullableUri = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableUri'] as String?).should.beNull();
    });
  });
}
