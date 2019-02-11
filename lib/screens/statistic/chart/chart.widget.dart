import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/screens/statistic/chart/period_dropdown/period_dropdown.dart';
import 'package:scheduler_app/screens/statistic/chart/round_chart.widget.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/statistic_period.selector.dart';

class GroupedFillColorBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double viewView = MediaQuery.of(context).size.width;
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      return {
        'data': getStisitcPeriodData(store.state),
      };
    }, builder: (context, state) {
      return Container(
        height: viewView / 5.0,
        width: viewView / 5.0,
        child: CustomPaint(
          foregroundPainter: RoundChartPainter(
              completePercent: state['data'], radius: viewView / 2.5),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: PeriodDropdownWidget())),
        ),
      );
    });
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
