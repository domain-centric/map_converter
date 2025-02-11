//import 'package:json_annotation/json_annotation.dart';
import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

/// dart run build_runner build

//@JsonSerializable()
@MapConverter()
class Example {
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
  Person myPerson = Person('John Doe', dateOfBirth: DateTime(1974, 11, 12));
  Person? myNullablePerson;
  Example myExample = Example();
  Example? myNullableExample;

  Iterable<Example> myExampleIterable = {};
  Iterable<Example>? myNullableExampleIterable;
}
