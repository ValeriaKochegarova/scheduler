import 'dart:async';
import 'package:redux_epics/redux_epics.dart';
import 'package:scheduler_app/common/database/database.helper.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';

final db = DatabaseHelper();

Stream<dynamic> getDealsFromDBEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is GetDealsPending)
      .asyncMap((action) => db.getDeals().then((deals) {
            return GetDealsSuccess(deals);
          }).catchError((error) {
            return GetDealsError(error);
          }));
}

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
