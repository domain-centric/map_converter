import '../../../example/lib/alias/alias.dart' as i1;

/// Do not make changes to this file!
/// This file is generated by package: map_converter
/// Input: map_converter/example/lib/alias/alias.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: https://pub.dev/packages/map_converter
i1.Example mapToExample(Map<String, dynamic> exampleMap) => i1.Example(
      name: exampleMap['name'] as String,
      email: exampleMap['emailAddress'] as String,
      phoneNumber: (exampleMap['contactNumber'] as num).toInt(),
    );
Map<String, dynamic> exampleToMap(i1.Example example) => {
      'emailAddress': example.email,
      'contactNumber': example.phoneNumber,
      'name': example.name,
    };
