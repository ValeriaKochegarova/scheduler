import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:reselect/reselect.dart';

var getSortedDeals = createSelector1(getDeals, (allDeals) {
  List notDoneDeals = allDeals.where((deal) => deal['done'] == 0).toList();
  List doneDeals = allDeals.where((deal) => deal['done'] == 1).toList();
  notDoneDeals
      .sort((dealA, dealB) => dealA['priority'].compareTo(dealB['priority']));
  doneDeals
      .sort((dealA, dealB) => dealA['priority'].compareTo(dealB['priority']));

  notDoneDeals.addAll(doneDeals);
  return notDoneDeals;
});

var getDealsByPriority = createSelector1(getDeals, (allDeals) {
  List priority0 = allDeals.where((deal) => deal['priority'] == 0).toList();
  List priority1 = allDeals.where((deal) => deal['priority'] == 1).toList();
  List priority2 = allDeals.where((deal) => deal['priority'] == 2).toList();
  List doneDeals = allDeals.where((deal) => deal['done'] == 1).toList();
  Map<String, Object> all = {
    'allCount': allDeals.length,
    'doneCount': doneDeals.length,
  };

  List dealsBypriority = [
    {"priority": 0, "deals": priority0},
    {"priority": 1, "deals": priority1},
    {"priority": 2, "deals": priority2}
  ].map((mappedDeals) {
    List deals = (mappedDeals['deals'] as List);
    List doneDeals = deals.where((deal) => deal['done'] == 1).toList();
    return  {
      'priority': mappedDeals['priority'],
      'allCount': deals.length,
      'doneCount': doneDeals.length,
    };
  }).toList();

 dealsBypriority.insert(0, all);
 return dealsBypriority;

});

var getDealsByPrioritySelector = createSelector2(getDeals,getPriorityFilter, (allDeals, priority) {
  return allDeals.where((deal) => deal['priority'] == priority).toList();
});