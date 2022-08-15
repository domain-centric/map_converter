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

@JsonSerializable()
class AllType {
  String myString = '';
  String? myNullableString;
  num myNum = 1;
  num? myNullableNum;
  int myInt = 1;
  int? myNullableInt;
  double myDouble = 1;
  double? myNullableDouble;
  bool myBool = false;
  bool? myNullableBool;
  Gender myEnum = Gender.male;
  Gender? myNullableEnum;
  Uri myUri = Uri(scheme: 'https', host: 'dart.dev');
  Uri? myNullableUri;
  BigInt myBigInt = BigInt.from(0);
  BigInt? myNullableBigInt;
  DateTime myDateTime = DateTime(2022);
  DateTime? myNullableDateTime;
  Duration myDuration = Duration.zero;
  Duration? myNullableDuration;
}
