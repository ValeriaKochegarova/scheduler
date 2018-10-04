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

      return CustomPaint(
        foregroundPainter: RoundChartPainter(
            lineColor: Colors.red[100],
            completeColor: Colors.lightGreen,
            completePercent: state['dealsCount'] / state['allCount'] * 100,
            width: 8.0,
            radius: viewView / 3),
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new RaisedButton(
              color: Colors.purple,
              splashColor: Colors.blueAccent,
              shape: new CircleBorder(),
              child: new Text("Click"),
              onPressed: () {
                // setState(() {
                //   // percentage += 10.0;
                //   // if(percentage>100.0){
                //   //   percentage=0.0;
                //   // }
                // });
              }),
        ),
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
