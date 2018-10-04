import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:reselect/reselect.dart';

var getSorteddDeals = createSelector1(
    getDeals,
    ( allDeals) => allDeals.sort((a, b) {
          if (a == false) {
            return -1;
          }
          return 0;
        }).toList());
