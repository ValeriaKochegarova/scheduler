import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/home/deals/deal/deal.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

class DealsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'deals': getDeals(store.state),
        'doneCb': (deal) {
          store.dispatch(UpdateDeal(deal));
        }
      };
    }, builder: (context, state) {
      return Column(
        children: state['deals'].map<Widget>((deal) {
          return Container(
              child: Deal(deal, state['doneCb'],
                  PriorityColor[deal['priority']], deal['done']));
        }).toList(),
      );
    });
  }
}
