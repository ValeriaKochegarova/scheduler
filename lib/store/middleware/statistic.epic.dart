import 'package:redux_epics/redux_epics.dart';
import 'package:scheduler_app/common/helpers/database.helper.dart';
import 'package:scheduler_app/store/actions/statistic_control.action.dart';
import 'package:scheduler_app/store/actions/statistic_period.action.dart';

final db = DatabaseHelper();

Stream<dynamic> statisticDateEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetStartOfStatisticPeriodPending)
      .asyncMap((action) => db.getFirstDeal().then((deal) {
            DateTime date = DateTime.now();
            if (deal.isNotEmpty) {
              date = DateTime.parse(deal[0]['date']);
            }
            return GetStartOfStatisticPeriodSuccess(date);
          }).catchError((error) {
            return GetStartOfStatisticPeriodError(error);
          }));
}

Stream<dynamic> statisticPeriodEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is SetPeriodPending)
      .asyncMap((action) => db.getDealsByPeriod(action.period).then((deals) {
            return SetPeriodSuccess(Map<String, dynamic>.from(action.period)
              ..addAll({'deals': deals}));
          }).catchError((error) {
            return SetPeriodError(error);
          }));
}
