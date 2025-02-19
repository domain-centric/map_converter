import '../../../example/lib/type/duration.dart' as i1;

/// Do not make changes to this file!
/// This file is generated by package: map_converter
/// Input: map_converter/example/lib/type/duration.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: https://pub.dev/packages/map_converter
i1.Example mapToExample(Map<String, dynamic> exampleMap) => i1.Example()
  ..myDuration = Duration(microseconds: exampleMap['myDuration'] as int)
  ..myNullableDuration = exampleMap['myNullableDuration'] == null
      ? null
      : Duration(microseconds: exampleMap['myNullableDuration'] as int);
Map<String, dynamic> exampleToMap(i1.Example example) => {
      'myDuration': example.myDuration.inMicroseconds,
      'myNullableDuration': example.myNullableDuration?.inMicroseconds,
    };
