import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/screens/home/progress/painter/painter.widget.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

class DonutPieChart extends StatelessWidget {
  final DateTime selectedDate;
  DonutPieChart(this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return getChartDealsData(store.state);
    }, builder: (context, state) {
      double viewView = MediaQuery.of(context).size.width;
      double percentage = state['allCount'] == 0
          ? 0.0
          : state['dealsCount'] / state['allCount'] * 100;

      print(selectedDate);    
      DateFormat formatter = DateFormat('M, d');
      String formattedDate = formatter.format(selectedDate);
      print(formattedDate);
      return state['allCount'] == 0
          ? Container()
          : CustomPaint(
              foregroundPainter: RoundChartPainter(
                  lineColor: Colors.red,
                  completeColor: Colors.lightGreen,
                  completePercent: percentage,
                  width: 8.0,
                  radius: viewView / 4),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Text(
                          '${percentage.round()}%',
                          style: TextStyle(
                              color: percentage < 60
                                  ? Colors.red
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
