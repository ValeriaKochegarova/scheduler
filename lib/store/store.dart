import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import './reducers/reducer.dart';
import '../store/middleware/deals.epic.dart';
import '../store/middleware/statistic.epic.dart';

String formatedDate = DateFormat('EEE, dd').format(DateTime.now());

var creationMiddleware = EpicMiddleware(createDealEpic);
var filterByDateMiddleware = EpicMiddleware(getDealsByDateEpic);
var statisticMiddleware = EpicMiddleware(statisticDateEpic);
var deleteDeal = EpicMiddleware(deleteDealEpic);
var updateDeal = EpicMiddleware(updateDealEpic);

final store = Store<AppState>(appStateReducer,
    initialState: AppState([], DateTime.now(), null, null, {'type': 0, 'date': DateTime.now()}),
    middleware: [
      creationMiddleware,
      filterByDateMiddleware,
      deleteDeal,
      updateDeal,
      statisticMiddleware
    ]);
