import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/custom/custom.dart';
import '../../../example/lib/custom/custom.mapper.dart';

void main() {
  group('exampleMapper.toMap(example) function', () {
    var example = Example(DateTime.fromMillisecondsSinceEpoch(10));
    var resultMap = const ExampleMapper().toMap(example);

    test("should.containKeyWithValue('dateTime', 10)", () {
      resultMap.should.containKeyWithValue('dateTime', 10);
    });
  });

  group('exampleMapper.fromMap(exampleMap) function', () {
    var exampleMap = {'dateTime': 10};
    var resultObject = const ExampleMapper().fromMap(exampleMap);

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
