import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat.yMd().format(date);
}

bool isYesterday(DateTime date) {
  DateTime now = DateTime.now();
  DateTime yesterdayEnd =
      DateTime(now.year, now.month, now.day - 1, 23, 59, 59);
  return yesterdayEnd.compareTo(date) != -1;
}

bool isTomorrow(DateTime date) {
  DateTime now = DateTime.now();
  DateTime tomorrowStart = DateTime(now.year, now.month, now.day, 23, 59, 59);
  return tomorrowStart.compareTo(date) == -1;
}
