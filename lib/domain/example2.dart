import 'package:json_annotation/json_annotation.dart';

/// dart run build_runner build
@JsonSerializable()
class Person {
  String name;
  DateTime dateOfBirth;
  List<Person> children;
  String hobby = '';
  Gender gender = Gender.unknown;

  Person({
    required this.name,
    required this.dateOfBirth,
    this.children = const [],
  });

  Duration get age => DateTime.now().difference(dateOfBirth);

  @override
  String toString() {
    return 'Person{name: $name, dateOfBirth: $dateOfBirth, children: $children, hobby: $hobby, gender: $gender}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          dateOfBirth == other.dateOfBirth &&
          children == other.children &&
          hobby == other.hobby &&
          gender == other.gender;

  @override
  int get hashCode =>
      name.hashCode ^
      dateOfBirth.hashCode ^
      children.hashCode ^
      hobby.hashCode ^
      gender.hashCode;
}

enum Gender { male, female, other, unknown }
