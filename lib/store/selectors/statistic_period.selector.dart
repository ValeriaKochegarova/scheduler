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
  print(period);
  if (period['type'] == 1) {
    return years;
  }
  return monthes;
});

var getStisitcPeriodData =
    createSelector2(getStatisticPeriod, getStatisticControl, (period, control) {
  print('getStatisticPeriod  =>>>> ${period['deals']}');
  List priority0 =
      period['deals'].where((deal) => deal['priority'] == 0).toList();
  List donePriority0 = priority0.where((deal) => deal['done'] == 1).toList();
  List priority1 =
      period['deals'].where((deal) => deal['priority'] == 1).toList();
  List donePriority1 = priority1.where((deal) => deal['done'] == 1).toList();
  List priority2 =
      period['deals'].where((deal) => deal['priority'] == 2).toList()..length;
  List donePriority2 = priority2.where((deal) => deal['done'] == 1).toList();

  double priority0Percentage = donePriority0.length/priority0.length ;
  double priority1Percentage = donePriority1.length/ priority1.length ;
  double priority2Percentage = donePriority2.length / priority2.length  ;

  return List<double>.from([
    priority0Percentage,
    priority1Percentage,
    priority2Percentage,
  ]);
});
// && DateTime(deal['date']).day == i
