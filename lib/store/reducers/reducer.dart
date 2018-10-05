import 'package:scheduler_app/store/reducers/calendar.reducer.dart';
import 'package:scheduler_app/store/reducers/deals.reducer.dart';

class AppState {
  final List deals;
  final dynamic date;
  AppState(this.deals, this.date);
}

AppState appStateReducer(AppState state, action) => AppState(
    dealsReducer(state.deals, action),
    calendarReducer(state.date, action)
    );

getDeals(AppState state) => state.deals;
getDate(AppState state) => state.date;
