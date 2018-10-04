import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:reselect/reselect.dart';

var getSorteddDeals = createSelector1(getDeals, (allDeals) {
  List notDoneDeals = allDeals.where((deal) => deal['done'] == false).toList();
  List doneDeals = allDeals.where((deal) => deal['done'] == true).toList();
  notDoneDeals
      .sort((dealA, dealB) => dealA['priority'].compareTo(dealB['priority']));
  doneDeals
      .sort((dealA, dealB) => dealA['priority'].compareTo(dealB['priority']));

  notDoneDeals.addAll(doneDeals);
  return notDoneDeals;
});
