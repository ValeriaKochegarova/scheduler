import 'package:scheduler_app/store/reducers/deals.reducer.dart';

class AppState {
  final List deals;
  AppState(this.deals);
}

AppState appStateReducer(AppState state, action) => AppState(
    dealsReducer(state.deals, action),
    );

getDeals(AppState state) => state.deals;
