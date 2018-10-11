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
            Map deal = Map.from(action.deal)..addAll({'id': id});
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

Stream<dynamic> markDealDoneEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is UpdateDealPending)
      .asyncMap((action) => db.markDoneDeal(action.payload).then((id) {
            return UpdateDealSuccess(action.payload);
          }).catchError((error) {
            return UpdateDealError(error);
          }));
}
Stream<dynamic> updateDealEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((action) => action is UpdateTextPending)
      .asyncMap((action) => db.updateDeal(action.payload).then((id) {
            return UpdateTextSuccess(action.payload);
          }).catchError((error) {
            return UpdateTextError(error);
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
