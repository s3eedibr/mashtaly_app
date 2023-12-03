import 'package:intl/intl.dart';

class Utils {
  static String getFormattedDateSimple(int time) {
    DateFormat newFormat = DateFormat("M/d/y");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedTimeSimple(int time) {
    DateFormat newFormat = DateFormat("h:mm a");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedDateTimeSimple(String formattedDateTime) {
    DateTime dateTime = DateTime.tryParse(formattedDateTime) ?? DateTime.now();
    DateFormat newFormat = DateFormat("M/d/y h:mm a");
    return newFormat.format(dateTime);
  }

  static DateTime parseFormattedDateSimple(String formattedDate) {
    DateFormat format = DateFormat("M/d/y");
    return format.parse(formattedDate);
  }
}
