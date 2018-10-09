import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/home/progress/painter/painter.widget.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

class DonutPieChart extends StatelessWidget {
  DonutPieChart();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'chartData': getChartDealsData(store.state),
        'selectedDate': store.state.date
      };
    }, builder: (context, state) {
      double viewView = MediaQuery.of(context).size.width;
      double percentage = state['chartData']['allCount'] == 0
          ? 0.0
          : state['chartData']['dealsCount'] /
              state['chartData']['allCount'] *
              100;
      return state['chartData']['allCount'] == 0
          ? Center(
              child: isYesterday(state['selectedDate'])
                  ? Text('У вас не было дел')
                  : Text('У вас еще нет дел'))
          : CustomPaint(
              foregroundPainter: RoundChartPainter(
                  completePercent: percentage, radius: viewView / 4),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        // Text(
                        //   formattedDate,
                        //   style: TextStyle(fontSize: 30.0),
                        // ),
                        Text(
                          '${percentage.round()}%',
                          style: TextStyle(
                              color: percentage < 40
                                  ? PriorityColor[0]
                                  : percentage >= 40 && percentage < 70
                                      ? PriorityColor[1]
                                      : PriorityColor[2],
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
