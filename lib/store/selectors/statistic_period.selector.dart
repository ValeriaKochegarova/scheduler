import 'package:reselect/reselect.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

var getStisitcPeriodDate = createSelector1(getStatisticPeriod, (period) {
  DateTime startDate = period['date'];
  int startYear = startDate.year;
  int startMonth = startDate.month;
  DateTime endtDate = DateTime.now();
  int endYear = endtDate.year;
  int endMonth = endtDate.month;
  List years = [];
  List monthes = [];
  for (int year = startYear; year <= endYear; year++) {
    years.add(DateTime(year));
    int monthForStart =
        year == startYear ? startMonth : year == endYear ? endMonth : 1;
    int monthForEnd =
        year == endYear ? endMonth : year == endYear ? endMonth : 12;
    for (int month = monthForStart; month <= monthForEnd; month++) {
      monthes.add(DateTime(year, month));
    }
  }
  print(period);
  if (period['type'] == 1) {
    return years;
  }
  return monthes;
});
