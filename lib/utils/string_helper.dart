import 'package:intl/intl.dart';

class StringHelper {
  static String formatLastOnline(DateTime? time) {
    if (time == null) return "Offline";
    return "Last seen at ${DateFormat('hh:mm a').format(time)}";
  }
}
