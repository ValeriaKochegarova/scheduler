import 'package:reselect/reselect.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

List<int> _daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) return 29;
    return 28;
  }
  return _daysInMonth[month - 1];
}

var getStisitcControl = createSelector1(getStatisticControl, (period) {
  DateTime startDate = period['date'];
  int startYear = startDate.year;
  int startMonth = startDate.month;
  DateTime endtDate = DateTime.now();
  int endYear = endtDate.year;
  int endMonth = endtDate.month;
  List years = [];
  List monthes = [];
  for (int year = startYear; year <= endYear; year++) {
    years.add({
      'lable': DateTime(year),
      'from': DateTime(year, 1, 1),
      'to': DateTime(year, 12, 31)
    });
    int monthForStart =
        year == startYear ? startMonth : 1; // year == endYear ? endMonth : 1;
    int monthForEnd =
        year == endYear ? endMonth : year == endYear ? endMonth : 12;

    for (int month = monthForStart; month <= monthForEnd; month++) {
      int dayInMonth = getDaysInMonth(year, month);
      monthes.add({
        'lable': DateTime(year, month),
        'from': DateTime(year, month, 1),
        'to': DateTime(year, month, dayInMonth)
      });
    }
  }
  if (period['type'] == 1) {
    return years;
  }
  return monthes;
});

var getStisitcPeriodData =
    createSelector2(getStatisticPeriod, getStatisticControl, (period, control) {
  List donePriority0;
  List priority0;
  List priority1;
  List donePriority1;
  List priority2;
  List donePriority2;
  double priority0Percentage;
  double priority1Percentage;
  double priority2Percentage;
  if (period['deals'] != null) {
    priority0 = period['deals'].where((deal) => deal['priority'] == 0).toList();
    donePriority0 = priority0.where((deal) => deal['done'] == 1).toList();
    priority1 = period['deals'].where((deal) => deal['priority'] == 1).toList();
    donePriority1 = priority1.where((deal) => deal['done'] == 1).toList();
    priority2 = period['deals'].where((deal) => deal['priority'] == 2).toList()
      ..length;
    donePriority2 = priority2.where((deal) => deal['done'] == 1).toList();
    priority0Percentage = donePriority0.length / priority0.length;
    priority1Percentage = donePriority1.length / priority1.length;
    priority2Percentage = donePriority2.length / priority2.length;
  }

  List<double> result = [
    priority0Percentage,
    priority1Percentage,
    priority2Percentage,
  ];
  return result;
});
