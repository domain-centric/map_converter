import 'package:map_converter/src/builder/value_expression_factory/value_expression_factory.dart';
import 'package:test/test.dart';
import 'package:shouldly/shouldly.dart';

import 'value_expression_factory_fake.dart';

void main() {
  group('createLibraryUri() function', () {
    test('dart:core should return null', () async {
      createLibraryUri(TypeFake(
                  typeAsString: 'int',
                  libraryUrl: 'dart:core',
                  isDartCoreType: true)
              .element)
          .should
          .beNull();
    });
    test('package:.. should return the same', () async {
      createLibraryUri(TypeFake(
                  typeAsString: 'Test',
                  libraryUrl: 'package:test/test.dart',
                  isDartCoreType: true)
              .element)
          .should
          .be('package:test/test.dart');
    });

    test('other path should return releative path', () async {
      createLibraryUri(TypeFake(
                  typeAsString: 'Test',
                  libraryUrl: 'test/my_test/test.dart',
                  isDartCoreType: true)
              .element)
          .should
          .be('../my_test/test.dart');
    });
  });
}
