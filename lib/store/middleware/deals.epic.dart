import 'dart:async';
import 'package:redux_epics/redux_epics.dart';
import 'package:scheduler_app/common/database/database.helper.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';

final db = DatabaseHelper();

Stream<dynamic> createDealEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is CreateDealPending)
      .asyncMap((action) => db.createDeal(action.deal).then((int index) {
            NavKeys.navKey.currentState.pop();
            return CreateDealSuccess(action.deal);
          }).catchError((error) {
            return CreateDealError(error);
          }));
}

Stream<dynamic> getDealsByDateEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetDealsByDatePending)
      .asyncMap((action) => db.getDealsByDate(store.state.date).then((deals) {
            return GetDealsByDateSuccess(deals);
          }).catchError((error) {
            return GetDealsByDateError(error);
          }));
}
