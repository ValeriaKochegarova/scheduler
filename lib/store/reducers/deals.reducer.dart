import 'package:scheduler_app/common/helpers/date.helper.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';

dynamic dealsReducer(List state, action) {
  if (action is UpdateDealSuccess) {
    state = state.map((deal) {
      if (deal['id'] != action.payload['id']) {
        return deal;
      }
      return action.payload;
    }).toList();
  }
  if (action is CreateDealSuccess) {
    if (isTomorrow(action.deal['date'])) {
      state.insert(0, action.deal);
      return action.deal;
    }
  }
  if (action is GetDealsByDateSuccess) {
    state.clear();
    state.insertAll(0, action.deals);
  }
  if (action is DeleteDealSuccess) {
    state.remove(action.deal);
    return state;
  }
  return List.from(state);
}
