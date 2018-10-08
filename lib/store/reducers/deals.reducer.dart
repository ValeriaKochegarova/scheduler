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
    return List.from(state);
  }
  if (action is CreateDealError) {
    return List.from(state);
  }
  if (action is GetDealsSuccess) {
    state.insertAll(0, action.deals);
    return List.from(state);
  }
  if (action is GetDealsError) {
    return List.from(state);
  }
  if (action is GetDealsByDateSuccess) {
    print({'FILTERED DEALS SUCCESS': action.deals});
    state.replaceRange(0, state.length, action.deals);
    // state.insertAll(0, action.deals);
    print(state.toList());
    return List.from(state);
  }
  if (action is GetDealsByDateError) {
    return List.from(state);
  }
  return List.from(state);
}
