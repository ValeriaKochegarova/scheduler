import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return  new DateFormat.yMd().format(date);
}
