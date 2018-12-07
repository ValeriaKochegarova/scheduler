import 'package:intl/intl.dart';
List<int> _daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) return 29;
    return 28;
  }
  return _daysInMonth[month-1];
}

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
