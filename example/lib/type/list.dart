import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

@MapConverter()
class Example {
  List<bool> boolList = [];
  List<bool?> boolListWithNullableBools = [];
  List<bool>? nullableBoolList = [];
  List<bool?>? nullableBoolListWithNullableBools = [];
  List<num> numList = [];
  List<num?>? nullableNumList;
  List<int> intList = [];
  List<int?>? nullableIntList;
  List<double> doubleList = [];
  List<double?>? nullableDoubleList;
  List<String> stringList = [];
  List<String?>? nullableStringList;
  List<Uri> uriList = [];
  List<Uri?>? nullableUriList;
  List<BigInt> bigIntList = [];
  List<BigInt?>? nullableBigIntList;
  List<DateTime> dateTimeList = [];
  List<DateTime?>? nullableDateTimeList;
  List<Duration> durationList = [];
  List<Duration?>? nullableDurationList;
  List<Gender> genderList = [];
  List<Gender?>? nullableGenderList;
  List<Person> personList = [];
  List<Person?>? nullablePersonList;
  //TODO  List<List<Person>> listOfPersonList = [];
  //TODO List<List<Person?>?>? nullableListOfNullablePersonList;
}
