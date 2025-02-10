import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

import '../../../example/lib/alias/alias.dart';
import '../../../example/lib/alias/alias_map_converter.dart';

void main() {
  group('exampleToMap(example) function', () {
    var example = Example(
        name: 'James', email: 'james@gmail.com', phoneNumber: 1234567890);
    var aliasExampleMap = exampleToMap(example);

    test("should.containKeyWithValue('name', 'James')", () {
      aliasExampleMap.should.containKeyWithValue('name', 'James');
    });

    test("should.containKeyWithValue('emailAddress', 'james@gmail.com')", () {
      aliasExampleMap.should
          .containKeyWithValue('emailAddress', 'james@gmail.com');
    });

    test("should.containKeyWithValue('contactNumber', 1234567890)", () {
      aliasExampleMap.should.containKeyWithValue('contactNumber', 1234567890);
    });
  });

  group('mapToExample(exampleMap) function', () {
    var exampleMap = {
      'name': 'James',
      'emailAddress': 'james@gmail.com',
      'contactNumber': 1234567890
    };
    var aliasExample = mapToExample(exampleMap);

    test("aliasExample.name.should.be('James')", () {
      aliasExample.name.should.be('James');
    });

    test("aliasExample.email.should.be('james@gmail.com')", () {
      aliasExample.email.should.be('james@gmail.com');
    });

    test("aliasExample.phoneNumber.should.be(1234567890)", () {
      aliasExample.phoneNumber.should.be(1234567890);
    });
  });
}
