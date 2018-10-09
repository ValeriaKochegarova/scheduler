// import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import './reducers/reducer.dart';
import '../store/middleware/deals.epic.dart';
import 'package:redux_epics/redux_epics.dart';

String formatedDate = DateFormat('EEE, dd').format(DateTime.now());

var creationMiddleware = EpicMiddleware(createDealEpic);
var filterByDateMiddleware = EpicMiddleware(getDealsByDateEpic);
var markDealDone = EpicMiddleware(markDealDoneEpic);
var deleteDeal = EpicMiddleware(deleteDealEpic);

final store = Store<AppState>(appStateReducer,
    initialState: AppState([], DateTime.now(), null),
    middleware: [creationMiddleware, filterByDateMiddleware, markDealDone, deleteDeal]);
