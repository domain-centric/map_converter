import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/custom_converter/custom_converter.dart';
import '../../../example/lib/custom_converter/custom_converter_map_converter.dart';

void main() {
  group('exampleToMap(example) function', () {
    var example = Example(DateTime.fromMillisecondsSinceEpoch(10));
    var resultMap = exampleToMap(example);

    test("should.containKeyWithValue('dateTime', 10)", () {
      resultMap.should.containKeyWithValue('dateTime', 10);
    });
  });

  group('mapToExample(exampleMap) function', () {
    var exampleMap = {'dateTime': 10};
    var resultObject = mapToExample(exampleMap);

    test("resultObject.should.beOfType<CustomMappingExample>()", () {
      resultObject.should.beOfType<Example>();
    });

    test(
        "resultObject.dateTime.should.be(DateTime.fromMicrosecondsSinceEpoch(10))",
        () {
      resultObject.dateTime.should.be(DateTime.fromMillisecondsSinceEpoch(10));
    });
  });
}
