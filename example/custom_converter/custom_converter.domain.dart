import 'package:map_converter/map_converter.dart';

@MapConverter([
  Property(
    'dateTime',
    converter: MyCustomConverter(),
  )
])
class CustomMappingExample {
  final DateTime dateTime;

  CustomMappingExample(this.dateTime);
}

class MyCustomConverter extends PrimitiveConverter<DateTime, int> {
  const MyCustomConverter();

  @override
  int toPrimitive(DateTime value) => value.millisecondsSinceEpoch;

  @override
  DateTime fromPrimitive(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value);
}
