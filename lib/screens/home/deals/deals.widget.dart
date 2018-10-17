import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/screens/home/deals/deal/deal.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

class DealsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'date': store.state.date,
        'dealsByPriority': getDealsByPrioritySelector(store.state),
        'choosenPriority' : store.state.priority,
        'deals': getDeals(store.state),
        'doneCb': (deal) {
          store.dispatch(UpdateMarkPending(deal));
        }
      };
    }, builder: (context, state) {
      return Column(
        children: (state['choosenPriority'] == null ? state['deals'] : state['dealsByPriority'])
        .map<Widget>((deal) {
          return GestureDetector(
              onTap: () => store.dispatch(SelectDeal(deal)),
              child: Container(
                  child:
                      Deal(deal, state['doneCb'], isYesterday(state['date']))));
        }).toList(),
      );
    });
  }
}
