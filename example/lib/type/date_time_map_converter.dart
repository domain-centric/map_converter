import '../../../example/lib/type/date_time.dart' as i1;

/// Do not make changes to this file!
/// This file is generated by package: map_converter
/// Input: map_converter/example/lib/type/date_time.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: https://pub.dev/packages/map_converter
i1.Example mapToExample(Map<String, dynamic> exampleMap) => i1.Example()
  ..myDateTime = DateTime.parse(exampleMap['myDateTime'] as String)
  ..myNullableDateTime = exampleMap['myNullableDateTime'] == null
      ? null
      : DateTime.parse(exampleMap['myNullableDateTime'] as String);
Map<String, dynamic> exampleToMap(i1.Example example) => {
      'myDateTime': example.myDateTime.toIso8601String(),
      'myNullableDateTime': example.myNullableDateTime?.toIso8601String(),
    };
