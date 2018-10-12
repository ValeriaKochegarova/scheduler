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
      .asyncMap((action) => db.createDeal(action.deal).then((int id) {
            NavKeys.navKey.currentState.pop();
            Map deal = action.deal..addAll({'id': id});
            return CreateDealSuccess(deal);
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


Stream<dynamic> updateDealEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is UpdateEditPending || action is UpdateMarkPending)
      .asyncMap((action) => db.updateDeal(action.payload).then((id) {
            action is UpdateEditPending 
            ? NavKeys.navKey.currentState.pop() 
            : null;
            return UpdateDealSuccess(action.payload);
          }).catchError((error) {
            return UpdateDealError(error);
          }));
}

Stream<dynamic> deleteDealEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is DeleteDealPending)
      .asyncMap((action) => db.deleteDeal(action.deal).then((id) {
            return DeleteDealSuccess(action.deal);
          }).catchError((error) {
            return DeleteDealError(error);
          }));
}
