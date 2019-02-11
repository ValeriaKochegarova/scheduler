import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/home/deals_filter_with_statistic/RoundChart/round_chart.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';
import 'package:scheduler_app/store/store.dart';

class DealsFilterWithStatistic extends StatelessWidget {
  List<Widget> _dealsByPriority(deals, currentPriority) {
    return List<Widget>.from(deals.map((deal) {
      if (deal == null) {
        return Container();
      }
      if (currentPriority == deal['priority']) {
        return RoundChartWidget(deal['doneCount'], deal['allCount']);
      }
      return InkWell(
        onTap: () {
          store.dispatch(SetPriorityFilter(deal['priority']));
        },
        child: Container(
          width: 50.0,
          height: 50.0,
          padding: EdgeInsets.only(top: 20.0, left: 20.0),
          child: Text('${deal['doneCount']}/${deal['allCount']}',
              style: TextStyle(
                  fontSize: 16.0, color: PriorityColor[deal['priority']])),
        ),
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'priority': store.state.priority,
        'dealsByPriority': getDealsByPriority(store.state),
        'UnsetPriorityDeal': () {
          store.dispatch(UnsetPriorityDeal());
        },
      };
    }, builder: (context, state) {
      return Row(
        children: <Widget>[
           Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _dealsByPriority(
                          state['dealsByPriority'], state['priority'])),
                ),
        ],
      );
    });
  }
}

class DealsPipeData {
  final int allCount;
  final int dealsCount;

  DealsPipeData(this.allCount, this.dealsCount);
}
