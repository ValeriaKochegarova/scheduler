import 'package:redux/redux.dart';
import 'package:scheduler_app/store/reducers/deals.reducer.dart';
import './reducers/reducer.dart';


final store = Store<AppState>(
  appStateReducer,
  initialState: AppState(deals, DateTime.now()),
);
