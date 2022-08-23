import 'package:map_converter/domain/person/person.dart' as _i1;

/// Do not make changes to this file!
/// This file is generated by: MapConverterBuilder
/// On: 2022-08-23 09:46:53.881218
/// From: /map_converter/lib/domain/person/person.dart
/// Generate command: dart run build_runner build --delete-conflicting-outputs
/// For more information see: TODO
Map<String, dynamic> personToMap(_i1.Person person) => {
      'name': person.name,
      'dateOfBirth': person.dateOfBirth.toIso8601String(),
      'hobby': person.hobby,
      'gender': person.gender.name
    };
