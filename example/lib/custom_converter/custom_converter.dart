import 'package:map_converter/map_converter.dart';

@MapConverter([
  Property(
    'dateTime',
    converter: MyConverter(),
  )
])
class Example {
  final DateTime dateTime;

  Example(this.dateTime);
}

class MyConverter extends PrimitiveConverter<DateTime, int> {
  const MyConverter();

  @override
  int toPrimitive(DateTime value) => value.millisecondsSinceEpoch;

  @override
  DateTime fromPrimitive(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value);
}
