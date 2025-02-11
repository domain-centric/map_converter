import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/duration.dart';
import '../../../example/lib/type/duration_map_converter.dart';

final durationValue = Duration(hours: 2);
void main() {
  group('mapToExample', () {
    test('myDuration should be correct', () {
      final exampleMap = {'myDuration': durationValue.inMicroseconds};
      final example = mapToExample(exampleMap);
      example.myDuration.should.be(durationValue);
    });
    test('myNullableDuration should be correct', () {
      final exampleMap = {
        'myDuration': durationValue.inMicroseconds,
        'myNullableDuration': durationValue.inMicroseconds,
      };
      final example = mapToExample(exampleMap);
      example.myNullableDuration.should.be(durationValue);
    });
    test('myNullableDuration with null should be correct', () {
      final exampleMap = {
        'myDuration': durationValue.inMicroseconds,
        'myNullableDuration': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableDuration.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myDuration should be correct', () {
      final example = Example()
        ..myDuration = durationValue
        ..myNullableDuration = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myDuration'] as int).should.be(durationValue.inMicroseconds);
    });
    test('myNullableDuration should be correct', () {
      final example = Example()
        ..myDuration = durationValue
        ..myNullableDuration = durationValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableDuration'] as int?)
          .should
          .be(durationValue.inMicroseconds);
    });
    test('myNullableDuration with null should be correct', () {
      final example = Example()
        ..myDuration = durationValue
        ..myNullableDuration = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableDuration'] as int?).should.beNull();
    });
  });
}
