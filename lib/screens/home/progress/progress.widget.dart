import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/home/progress/painter/painter.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';
import 'package:scheduler_app/store/store.dart';

class DonutPieChart extends StatelessWidget {
  List<Widget> _dealsByPriority(deals) {
    return List<Widget>.from(deals.map((deal) {
      if (deal != null) {
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
      }
      return Container();
    }).toList());
  }

  List<Widget> _concat(List<Widget> widhetList, newWidgetList) {
    widhetList.addAll(newWidgetList);
    return widhetList;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'chartData': getChartDealsData(store.state),
        'dealsByPriority': getDealsByPriority(store.state),
        'UnsetPriorityDeal': () {
          store.dispatch(UnsetPriorityDeal());
        },
      };
    }, builder: (context, state) {
      double viewView = MediaQuery.of(context).size.width;
      double percentage = state['chartData']['allCount'] == 0
          ? 0.0
          : state['chartData']['dealsCount'] /
              state['chartData']['allCount'] *
              100;
      return Row(
        children: <Widget>[
          state['chartData']['allCount'] == 0
              ? Container()
              : Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _concat(<Widget>[
                        InkWell(
                          onTap: () {
                            state['UnsetPriorityDeal']();
                          },
                          child: Container(
                            height: viewView / 7.5,
                            child: CustomPaint(
                              foregroundPainter: RoundChartPainter(
                                  completePercent: percentage,
                                  radius: viewView / 14),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      '${percentage.round()}%',
                                      style: TextStyle(
                                          color: percentage < 40
                                              ? PriorityColor[0]
                                              : percentage >= 40 &&
                                                      percentage < 70
                                                  ? PriorityColor[1]
                                                  : PriorityColor[2],
                                          fontSize: 16.0),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ], _dealsByPriority(state['dealsByPriority']))),
                ),
        ],
      );
    });
  }

  /// Create one series with sample hard coded data.
}

/// Sample linear data type.
class DealsPipeData {
  final int allCount;
  final int dealsCount;

  DealsPipeData(this.allCount, this.dealsCount);
}
