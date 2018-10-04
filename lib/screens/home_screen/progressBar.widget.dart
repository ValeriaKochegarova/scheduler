/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/deals.selector.dart';

class DonutPieChart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return getChartDealsData(store.state);
    }, builder: (context, state) {
      return new charts.PieChart(
          _createSampleData(state['allCount'],state['dealsCount']),
          animate: false,
          defaultRenderer: new charts.ArcRendererConfig(arcWidth: 20));
    });
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<DealsPipeData, int>> _createSampleData(all,count) {
    final data = [
      new DealsPipeData(1, count),
      new DealsPipeData(2, all-count),
    ];

    return [
      new charts.Series<DealsPipeData, int>(
        id: 'Deals',
        domainFn: (DealsPipeData pipeData, _) => pipeData.allCount,
        measureFn: (DealsPipeData pipeData, _) => pipeData.dealsCount,
        data: data
      )
    ];
  }
}

/// Sample linear data type.
class DealsPipeData {
  final int allCount;
  final int dealsCount;

  DealsPipeData(this.allCount, this.dealsCount);
}
