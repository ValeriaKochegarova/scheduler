import 'package:scheduler_app/store/actions/deals.action.dart';

List deals = [
  {'id': 1, 'text': 'Lorem ipsum dolor', 'done': false, 'priority': 0},
  {'id': 2, 'text': 'Test text asdasdasd', 'done': false,'priority': 2},
  {'id': 3, 'text': 'Tesdfgdfhfgc', 'done': false,'priority': 0},
  {'id': 4, 'text': 'Cghfgxfgdfgdfgdfg', 'done': false,'priority': 1},
  {'id': 5, 'text': 'Tsedfgdhydgdfgfr', 'done': false,'priority': 2}
];

List initialState = deals;

dynamic dealsReducer(List state, action) {
  if (action is UpdateDeal) {
    state = state.map((deal) {
      if (deal['id'] != action.payload['id']) {
        return deal;
      }
      return action.payload;
    }).toList();
  }
  return List.from(state);
}
