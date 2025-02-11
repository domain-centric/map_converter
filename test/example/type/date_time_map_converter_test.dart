import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/type/date_time.dart';
import '../../../example/lib/type/date_time_map_converter.dart';

final dateTimeValue = DateTime.now();
void main() {
  group('mapToExample', () {
    test('myDateTime should be correct', () {
      final exampleMap = {'myDateTime': dateTimeValue.toIso8601String()};
      final example = mapToExample(exampleMap);
      example.myDateTime.should.be(dateTimeValue);
    });
    test('myNullableDateTime should be correct', () {
      final exampleMap = {
        'myDateTime': dateTimeValue.toIso8601String(),
        'myNullableDateTime': dateTimeValue.toIso8601String(),
      };
      final example = mapToExample(exampleMap);
      example.myNullableDateTime.should.be(dateTimeValue);
    });
    test('myNullableDateTime with null should be correct', () {
      final exampleMap = {
        'myDateTime': dateTimeValue.toIso8601String(),
        'myNullableDateTime': null,
      };
      final example = mapToExample(exampleMap);
      example.myNullableDateTime.should.beNull();
    });
  });

  group('exampleToMap', () {
    test('myDateTime should be correct', () {
      final example = Example()
        ..myDateTime = dateTimeValue
        ..myNullableDateTime = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myDateTime'] as String)
          .should
          .be(dateTimeValue.toIso8601String());
    });
    test('myNullableDateTime should be correct', () {
      final example = Example()
        ..myDateTime = dateTimeValue
        ..myNullableDateTime = dateTimeValue;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableDateTime'] as String?)
          .should
          .be(dateTimeValue.toIso8601String());
    });
    test('myNullableDateTime with null should be correct', () {
      final example = Example()
        ..myDateTime = dateTimeValue
        ..myNullableDateTime = null;
      final exampleMap = exampleToMap(example);
      (exampleMap['myNullableDateTime'] as String?).should.beNull();
    });
  });
}
