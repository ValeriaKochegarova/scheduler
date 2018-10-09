import 'package:scheduler_app/store/reducers/calendar.reducer.dart';
import 'package:scheduler_app/store/reducers/deals.reducer.dart';
import 'package:scheduler_app/store/reducers/selectDeal.reducer.dart';

class AppState {
  final List deals;
  final dynamic date;
  final dynamic selectedDeal;
  AppState(this.deals, this.date, this.selectedDeal);
}

AppState appStateReducer(AppState state, action) => AppState(
    dealsReducer(state.deals, action),
    calendarReducer(state.date, action),
    selectedDealReducer(state.selectedDeal, action));

getDeals(AppState state) => state.deals;
getDate(AppState state) => state.date;
getSelectedDeal(AppState state) => state.selectedDeal;
