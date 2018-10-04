import 'package:redux/redux.dart';
import './reducers/reducer.dart';

List deals = [
  {'text': 'Lorem ipsum dolor', 'done': false},
  {'text': 'Test text asdasdasd', 'done': false},
  {'text': 'Tesdfgdfhfgc', 'done': false},
  {'text': 'Cghfgxfgdfgdfgdfg', 'done': false},
  {'text': 'Tsedfgdhydgdfgfr', 'done': false}
];

final store = Store<AppState>(
  appStateReducer,
  initialState: AppState(deals),
);
