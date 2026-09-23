import 'package:map_converter/map_converter.dart';

@MapConverter(fields: [
  Field<DateTime, int>(#dateTime,
      toMapValue: dateTimeToMapValue, fromMapValue: dateTimeFromMapValue)
])
class Example {
  final DateTime dateTime;

  Example(this.dateTime);
}

int dateTimeToMapValue(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

DateTime dateTimeFromMapValue(int millisecondsSinceEpoch) =>
    DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
