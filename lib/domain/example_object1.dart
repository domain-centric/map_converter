import 'package:json_annotation/json_annotation.dart';

import 'example_object2.dart';

/// dart run build_runner build

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
