import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/duration.dart';
import '../../../example/lib/type/duration.mapper.dart';

final durationValue = Duration(hours: 2);
void main() {
  final exampleMapper = const ExampleMapper();
  group('exampleMapper.fromMap', () {
    test('myDuration should be correct', () {
      final exampleMap = {'myDuration': durationValue.inMicroseconds};
      final example = exampleMapper.fromMap(exampleMap);
      example.myDuration.should.be(durationValue);
    });
    test('myNullableDuration should be correct', () {
      final exampleMap = {
        'myDuration': durationValue.inMicroseconds,
        'myNullableDuration': durationValue.inMicroseconds,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableDuration.should.be(durationValue);
    });
    test('myNullableDuration with null should be correct', () {
      final exampleMap = {
        'myDuration': durationValue.inMicroseconds,
        'myNullableDuration': null,
      };
      final example = exampleMapper.fromMap(exampleMap);
      example.myNullableDuration.should.beNull();
    });
  });

  group('exampleMapper.toMap', () {
    test('myDuration should be correct', () {
      final example = Example()
        ..myDuration = durationValue
        ..myNullableDuration = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myDuration'] as int).should.be(durationValue.inMicroseconds);
    });
    test('myNullableDuration should be correct', () {
      final example = Example()
        ..myDuration = durationValue
        ..myNullableDuration = durationValue;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableDuration'] as int?)
          .should
          .be(durationValue.inMicroseconds);
    });
    test('myNullableDuration with null should be correct', () {
      final example = Example()
        ..myDuration = durationValue
        ..myNullableDuration = null;
      final exampleMap = exampleMapper.toMap(example);
      (exampleMap['myNullableDuration'] as int?).should.beNull();
    });
  });
}
