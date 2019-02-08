import 'package:scheduler_app/store/reducers/calendar.reducer.dart';
import 'package:scheduler_app/store/reducers/deals.reducer.dart';
import 'package:scheduler_app/store/reducers/dealsByPriority.reducer.dart';
import 'package:scheduler_app/store/reducers/selectDeal.reducer.dart';
import 'package:scheduler_app/store/reducers/statistic_control.reducer.dart';
import 'package:scheduler_app/store/reducers/statistic_period.reducer.dart';

class AppState {
  final List deals;
  final dynamic date;
  final dynamic selectedDeal;
  final dynamic priority;
  final Map<String, dynamic> statisticControl;
  final Map<String, dynamic> statisticPeriod;
  final bool isEdit;
  AppState(this.deals, this.date, this.selectedDeal, this.priority,
      this.statisticControl, this.statisticPeriod, this.isEdit);
}

AppState appStateReducer(AppState state, action) => AppState(
      dealsReducer(state.deals, action),
      calendarReducer(state.date, action),
      selectedDealReducer(state.selectedDeal, action),
      dealsByPriorityReducer(state.priority, action),
      statisticControlReducer(state.statisticControl, action),
      statisticPeriodReducer(state.statisticPeriod, action),
      isEditReducer(state.isEdit, action)
    );

getDeals(AppState state) => state.deals;
getDate(AppState state) => state.date;
getPriorityFilter(AppState state) => state.priority;
getSelectedDeal(AppState state) => state.selectedDeal;
getStatisticControl(AppState state) => state.statisticControl;
getStatisticPeriod(AppState state) => state.statisticPeriod;
