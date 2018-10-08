import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return new DateFormat.yMd().format(date);
}

bool isYesterday(DateTime date) {
  DateTime now = DateTime.now();
  DateTime yesterdayEnd =
      DateTime(now.year, now.month, now.day - 1, 23, 59, 59);
  return yesterdayEnd.compareTo(date) != -1;
}
