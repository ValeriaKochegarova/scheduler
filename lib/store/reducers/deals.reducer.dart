import 'package:scheduler_app/store/actions/deals.action.dart';

List initialState = [];

dynamic dealsReducer(List state, action) {
  if (action is UpdateDeal) {
    state = state.map((deal) {
      if (deal['id'] != action.payload['id']) {
        return deal;
      }
      return action.payload;
    }).toList();
  }
  if (action is CreateDealSuccess) {
    state.insert(0, action.deal);
  }

  if (action is GetDealsByDateSuccess) {
    state.clear();
    state.insertAll(0,action.deals);
  }
  return List.from(state);
}
