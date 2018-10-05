import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:reselect/reselect.dart';

var getSorteddDeals = createSelector1(getDeals, (allDeals) {
    print('call sorted deals');
  List notDoneDeals = allDeals.where((deal) => deal['done'] == false).toList();
  List doneDeals = allDeals.where((deal) => deal['done'] == true).toList();
  notDoneDeals
      .sort((dealA, dealB) => dealA['priority'].compareTo(dealB['priority']));
  doneDeals
      .sort((dealA, dealB) => dealA['priority'].compareTo(dealB['priority']));

  notDoneDeals.addAll(doneDeals);
  return notDoneDeals;
});

var getChartDealsData = createSelector1(getDeals, (allDeals) {
  List doneDeals = allDeals.where((deal) => deal['done'] == true).toList();
  Map pipeData =  {
    'allCount': allDeals.length,
    'dealsCount': doneDeals.length,
  };
  return pipeData;
});
