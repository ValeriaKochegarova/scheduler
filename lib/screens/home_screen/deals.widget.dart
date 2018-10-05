import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/screens/home_screen/deal.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

Map<int, Color> priorityColor = {
  1: Colors.red,
  2: Colors.orange,
  3: Colors.green,
};

class DealsWidget extends StatefulWidget {
  @override
  _DealsWidgetState createState() => _DealsWidgetState();
}

class _DealsWidgetState extends State<DealsWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'deals': getSorteddDeals(store.state),
        'doneCb': (deal) {
          store.dispatch(UpdateDeal(deal));
        }
      };
    }, builder: (context, state) {
      return Column(
        children: state['deals'].map<Widget>((deal) {
          return Container(
              child:
                  Deal(deal, state['doneCb'], priorityColor[deal['priority']]));
        }).toList(),
      );
    });
  }
}
