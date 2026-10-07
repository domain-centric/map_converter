import 'package:dart_code/dart_code.dart' as code;
import 'package:map_converter/src/builder/map_converter_builder.dart';
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

    test('other path should return relative path', () async {
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

/// generic test functions

code.Expression objectPropertyExpression(
        String instanceVariableName, String propertyName) =>
    code.Expression.ofVariable(instanceVariableName).getProperty(propertyName);

code.Expression mapValueExpression(
        String mapVariableName, String propertyName) =>
    code.Expression.ofVariable(mapVariableName)
        .index(code.Expression.ofString(propertyName));
