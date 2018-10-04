import 'package:scheduler_app/store/actions/deals.action.dart';

List deals = [
  {'id': 1, 'text': 'Lorem ipsum dolor', 'done': false},
  {'id': 2, 'text': 'Test text asdasdasd', 'done': false},
  {'id': 3, 'text': 'Tesdfgdfhfgc', 'done': false},
  {'id': 4, 'text': 'Cghfgxfgdfgdfgdfg', 'done': false},
  {'id': 5, 'text': 'Tsedfgdhydgdfgfr', 'done': false}
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
