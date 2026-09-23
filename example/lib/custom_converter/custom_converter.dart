import 'package:map_converter/map_converter.dart';

@MapConverter(fields: [
  Field<DateTime, int>(#dateTime,
      toPrimitiveConverter: dateTimeToPrimitive,
      fromPrimitiveConverter: dateTimeFromPrimitive)
])
class Example {
  final DateTime dateTime;

  Example(this.dateTime);
}

int dateTimeToPrimitive(DateTime value) => value.millisecondsSinceEpoch;

DateTime dateTimeFromPrimitive(int value) =>
    DateTime.fromMillisecondsSinceEpoch(value);
