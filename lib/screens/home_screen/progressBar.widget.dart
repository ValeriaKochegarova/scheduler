/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/screens/home_screen/painter.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

class DonutPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return getChartDealsData(store.state);
    }, builder: (context, state) {
      double viewView = MediaQuery.of(context).size.width;

      double percentage = state['dealsCount'] / state['allCount'] * 100;

      return CustomPaint(
        foregroundPainter: RoundChartPainter(
            lineColor: Colors.red[100],
            completeColor: Colors.lightGreen,
            completePercent: percentage,
            width: 8.0,
            radius: viewView / 3),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    'Пн, 30',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text(
                    '${percentage.round()}%',
                    style: TextStyle(
                        color: percentage < 60
                            ? Colors.red[100]
                            : Colors.lightGreen,
                        fontSize: 40.0),
                  ),
                ]))),
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
