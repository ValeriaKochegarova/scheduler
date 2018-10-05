import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import './reducers/reducer.dart';
import '../store/middleware/deals.epic.dart';
import 'package:redux_epics/redux_epics.dart';

String formatedDate = DateFormat('EEE, dd').format(DateTime.now());

var dealsMiddleware = EpicMiddleware(getDealsFromDBEpic);
var creationMiddleware = EpicMiddleware(createDealEpic);

final store = Store<AppState>(appStateReducer,
    initialState: AppState([], formatedDate),
    middleware: [dealsMiddleware, creationMiddleware]);
