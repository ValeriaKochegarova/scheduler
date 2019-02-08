import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/helpers/date.helper.dart';
import 'package:scheduler_app/screens/home/deals/deal/deal.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

class DealsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'date': store.state.date,
        'dealsByPriority': getDealsByPrioritySelector(store.state),
        'choosenPriority': store.state.priority,
        'deals': getDeals(store.state),
        'selectedDate': store.state.date,
        'doneCb': (deal) {
          store.dispatch(UpdateMarkPending(deal));
        },
        'editCb': (deal) {
          store.dispatch(SelectDeal(deal));
          Navigator.pushNamed(context, '/create');
        },
        'removeCb': (deal) {
          store.dispatch(DeleteDealPending(deal));
        }
      };
    }, builder: (context, state) {
      return List.from(state['dealsByPriority']).length == 0 &&
                  state['choosenPriority'] != null ||
              List.from(state['deals']).length == 0
          ? Center(
              child: isYesterday(state['selectedDate'])
                  ? Text(
                      'У вас не было дел',
                      style: TextStyle(color: Colors.white, fontSize: 18.00),
                    )
                  : Text(
                      'У вас еще нет дел',
                      style: TextStyle(color: Colors.white, fontSize: 18.00),
                    ))
          : ListView(
              children: (state['choosenPriority'] == null
                      ? state['deals']
                      : state['dealsByPriority'])
                  .map<Widget>((deal) {
                return Container(
                    child: Deal(
                        deal,
                        isYesterday(state['date']),
                        isTomorrow(state['date']),
                        state['doneCb'],
                        state['editCb'],
                        state['removeCb']));
              }).toList(),
            );
    });
  }
}
