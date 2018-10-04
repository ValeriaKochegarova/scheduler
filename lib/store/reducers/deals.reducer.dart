List deals = [
  {'text': 'Lorem ipsum dolor', 'done': false},
  {'text': 'Test text asdasdasd', 'done': false},
  {'text': 'Tesdfgdfhfgc', 'done': false},
  {'text': 'Cghfgxfgdfgdfgdfg', 'done': false},
  {'text': 'Tsedfgdhydgdfgfr', 'done': false}
];

List initialState = deals;

dynamic dealsReducer(List state, action) {
  return List.from(state);
}
