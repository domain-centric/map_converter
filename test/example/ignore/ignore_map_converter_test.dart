import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/ignore/ignore.dart';
import '../../../example/lib/ignore/ignore_map_converter.dart';

void main() {
  group('exampleToMap(example) function', () {
    var example = Example()
      ..keep = false
      ..skip = 'do not convert';
    var ignoreMap = exampleToMap(example);

    test("should.containKeyWithValue('keep', false)", () {
      ignoreMap.should.containKeyWithValue('keep', false);
    });

    test("should.not.containKey('ignore')", () {
      ignoreMap.should.not.containKey('ignore');
    });
  });

  group('mapToExample(exampleMap) function', () {
    var exampleMap = {'keep': false, 'skip': 'do not convert'};
    var ignore = mapToExample(exampleMap);

    test("ignore.keep.should.be( false)", () {
      ignore.keep.should.be(false);
    });

    test("should.not.containKey('ignore')", () {
      ignore.skip.should.be('ignore');
    });
  });
}
