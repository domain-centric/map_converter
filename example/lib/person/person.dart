import 'package:map_converter/map_converter.dart';

@MapConverter()
class Person {
  String name;
  DateTime dateOfBirth;
  List<Person> children;
  String hobby;
  Gender gender;

  Person(
    this.name, {
    required this.dateOfBirth,
    this.hobby = '',
    this.gender = Gender.unknown,
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
