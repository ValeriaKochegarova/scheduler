import 'package:scheduler_app/store/actions/statistic_period.action.dart';

dynamic statisticPeriodReducer(Map<String, dynamic> state, action) {
  if (action is SetPeriodSuccess) {
    state = action.period;
  }

  return Map<String, dynamic>.from(state);
}
