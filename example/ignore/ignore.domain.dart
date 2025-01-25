import 'package:map_converter/map_converter.dart';

@MapConverter([Property.ignore('skip')])
class IgnoreExample {
  bool keep = true;
  String skip = 'ignore';
}
