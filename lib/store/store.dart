import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:scheduler_app/store/reducers/deals.reducer.dart';
import './reducers/reducer.dart';

String formatedDate = DateFormat('EEE, dd').format(DateTime.now());

final store = Store<AppState>(
  appStateReducer,
  initialState: AppState(deals, formatedDate),
);
