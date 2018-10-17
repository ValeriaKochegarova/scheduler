import 'package:scheduler_app/store/reducers/calendar.reducer.dart';
import 'package:scheduler_app/store/reducers/deals.reducer.dart';
import 'package:scheduler_app/store/reducers/dealsByPriority.reducer.dart';
import 'package:scheduler_app/store/reducers/selectDeal.reducer.dart';

class AppState {
  final List deals;
  final dynamic date;
  final dynamic selectedDeal;
  final dynamic priority;
  AppState(this.deals, this.date, this.selectedDeal, this.priority);
}

AppState appStateReducer(AppState state, action) => AppState(
    dealsReducer(state.deals, action),
    calendarReducer(state.date, action),
    selectedDealReducer(state.selectedDeal, action),
    dealsByPriorityReducer(state.priority, action));

getDeals(AppState state) => state.deals;
getDate(AppState state) => state.date;
getPriorityFilter(AppState state) => state.priority;
getSelectedDeal(AppState state) => state.selectedDeal;
displayDealsByPriority(AppState state) => state.deals;
