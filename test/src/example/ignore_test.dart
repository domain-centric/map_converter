import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/ignore/ignore.domain.dart';
import '../../../example/ignore/ignore_map_converter.data.dart';

void main() {
  group('ignoreToMap(ignore) function', () {
    var ignore = IgnoreExample()
      ..keep = false
      ..skip = 'do not convert';
    var ignoreMap = ignoreExampleToMap(ignore);

    test("should.containKeyWithValue('keep', false)", () {
      ignoreMap.should.containKeyWithValue('keep', false);
    });

    test("should.not.containKey('ignore')", () {
      ignoreMap.should.not.containKey('ignore');
    });
  });

  group('mapToIgnore(ignoreMap) function', () {
    var ignoreMap = {'keep': false, 'skip': 'do not convert'};
    var ignore = mapToIgnoreExample(ignoreMap);

    test("ignore.keep.should.be( false)", () {
      ignore.keep.should.be(false);
    });

    test("should.not.containKey('ignore')", () {
      ignore.skip.should.be('ignore');
    });
  });
}
