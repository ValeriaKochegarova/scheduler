import 'package:scheduler_app/store/actions/statistic_period.action.dart';

dynamic statisticPeriodReducer(Map<String, dynamic> state, action) {
  if (action is SetMonthPeriod) {
    state['type'] = 0;
  }

  if (action is SetYearPeriod) {
    state['type'] = 1;
  }
  if (action is GetStartOfStatisticPeriodSuccess) {
    state['date'] = action.date;
  }

  return Map<String, dynamic>.from(state);
}
