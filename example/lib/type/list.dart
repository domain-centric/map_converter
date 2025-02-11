import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

@MapConverter()
class Example {
  late List<bool> boolList;
  late List<bool?> boolListWithNullableBools;
  late List<bool>? nullableBoolList;
  late List<bool?>? nullableBoolListWithNullableBools;
  late List<num> numList;
  late List<num?>? nullableNumList;
  late List<int> intList;
  late List<int?>? nullableIntList;
  late List<double> doubleList;
  late List<double?>? nullableDoubleList;
  late List<String> stringList;
  late List<String?>? nullableStringList;
  late List<Uri> uriList;
  late List<Uri?>? nullableUriList;
  late List<BigInt> bigIntList;
  late List<BigInt?>? nullableBigIntList;
  late List<DateTime> dateTimeList;
  late List<DateTime?>? nullableDateTimeList;
  late List<Duration> durationList;
  late List<Duration?>? nullableDurationList;
  late List<Gender> genderList;
  late List<Gender?>? nullableGenderList;
  late List<Person> personList;
  late List<Person?>? nullablePersonList;
  //TODO  List<List<Person>> listOfPersonList;
  //TODO List<List<Person?>?>? nullableListOfNullablePersonList;
}
