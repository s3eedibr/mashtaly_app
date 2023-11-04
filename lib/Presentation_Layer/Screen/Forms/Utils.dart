import 'package:intl/intl.dart';

class Utils {
  static String getFormattedDateSimple(int time) {
    DateFormat newFormat = DateFormat("M/d/y");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }
}
