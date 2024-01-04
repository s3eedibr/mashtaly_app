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

  static String getTimeAgo(String formattedDateTime) {
    final DateTime postDate =
        DateTime.tryParse(formattedDateTime) ?? DateTime.now();

    final Duration difference = DateTime.now().difference(postDate);

    if (difference.inDays > 365) {
      return DateFormat('MMM d, y').format(postDate);
    } else if (difference.inDays > 30) {
      return DateFormat('MMM d').format(postDate);
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'a moment ago';
    }
  }
}
