import 'package:json_annotation/json_annotation.dart';

import 'person/person.dart';

/// dart run build_runner build

@JsonSerializable()
class Example {
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
  Person myPerson =
      Person(name: 'John Doe', dateOfBirth: DateTime(1974, 11, 12));
  Person? myNullablePerson;
  Example myExample = Example();
  Example? myNullableExample;
  List<Example> myExampleList = [];
  List<Example>? myNullableExampleList;
  Set<Example> myExampleSet = {};
  Set<Example>? myNullableExampleSet;
  Iterable<Example> myExampleIterable = {};
  Iterable<Example>? myNullableExampleIterable;
  Map<int, Example> myIntExampleMap = {};
  Map<int, Example>? myNullableIntExampleMap;
}
