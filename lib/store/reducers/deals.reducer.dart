import 'package:scheduler_app/store/actions/deals.action.dart';

// List deals = [
//   {'id': 1, 'text': 'Lorem ipsum dolor', 'done': false, 'priority': 1},
//   {'id': 2, 'text': 'Test text asdasdasd', 'done': false, 'priority': 3},
//   {'id': 3, 'text': 'Tesdfgdfhfgc', 'done': false, 'priority': 1},
//   {'id': 4, 'text': 'Cghfgxfgdfgdfgdfg', 'done': false, 'priority': 2},
//   {'id': 5, 'text': 'Tsedfgdhydgdfgfr', 'done': false, 'priority': 3},
//   {'id': 6, 'text': 'Lorem ipsum dolor', 'done': false, 'priority': 1},
//   {'id': 7, 'text': 'Test text asdasdasd', 'done': false, 'priority': 3},
//   {'id': 8, 'text': 'Tesdfgdfhfgc', 'done': false, 'priority': 1},
//   {'id': 9, 'text': 'Cghfgxfgdfgdfgdfg', 'done': false, 'priority': 2},
//   {'id': 10, 'text': 'Tsedfgdhydgdfgfr', 'done': false, 'priority': 3},
// ];

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
    print({'GET DEALS SUCCESS': action.deals});
    state.insertAll(0, action.deals);
    print(state.toList());
    return List.from(state);
  }
  if (action is GetDealsError) {
    return List.from(state);
  }
  return List.from(state);
}
