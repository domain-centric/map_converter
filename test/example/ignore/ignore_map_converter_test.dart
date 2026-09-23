import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/ignore/ignore.dart';
import '../../../example/lib/ignore/ignore.mapper.dart';

void main() {
  group('exampleMapper.toMap(example) function', () {
    var example = Example()
      ..keep = false
      ..skip = 'do not convert';
    var ignoreMap = const ExampleMapper().toMap(example);

    test("should.containKeyWithValue('keep', false)", () {
      ignoreMap.should.containKeyWithValue('keep', false);
    });

    test("should.not.containKey('ignore')", () {
      ignoreMap.should.not.containKey('ignore');
    });
  });

  group('exampleMapper.fromMap(exampleMap) function', () {
    var exampleMap = {'keep': false, 'skip': 'do not convert'};
    var ignore = const ExampleMapper().fromMap(exampleMap);

    test("ignore.keep.should.be( false)", () {
      ignore.keep.should.be(false);
    });

    test("should.not.containKey('ignore')", () {
      ignore.skip.should.be('ignore');
    });
  });
}
