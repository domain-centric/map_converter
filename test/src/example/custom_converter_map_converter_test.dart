import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/custom_converter/custom_converter.domain.dart';
import '../../../example/custom_converter/custom_converter_map_converter.data.dart';

void main() {
  group('customMappingExampleToMap(customMappingExample) function', () {
    var customMappingExample = CustomMappingExample(DateTime.fromMillisecondsSinceEpoch(10));
    var resultMap = customMappingExampleToMap(customMappingExample);

    test("should.containKeyWithValue('dateTime', 10)", () {
      resultMap.should.containKeyWithValue('dateTime', 10);
    });
  });

  group('mapToCustomMappingExample(customMappingExampleMap) function', () {
    var map = {'dateTime': 10};
    var resultObject = mapToCustomMappingExample(map);

    test("resultObject.should.beOfType<CustomMappingExample>()", () {
      resultObject.should.beOfType<CustomMappingExample>();
    });

    test("resultObject.dateTime.should.be(DateTime.fromMicrosecondsSinceEpoch(10))", () {
      resultObject.dateTime.should.be(DateTime.fromMillisecondsSinceEpoch(10));
    });
  });
}
