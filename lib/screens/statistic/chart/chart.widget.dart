/// Bar chart example
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/screens/statistic/chart/period_dropdown/period_dropdown.dart';
import 'package:scheduler_app/screens/statistic/chart/round_chart.widget.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/statistic_period.selector.dart';

/// Example of a grouped bar chart with three series, each rendered with
/// different fill colors.
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

//  final List<charts.Series> seriesList;
//   final bool animate;

//   StackedAreaLineChart(this.seriesList, {this.animate});

//   /// Creates a [LineChart] with sample data and no transition.
//   factory StackedAreaLineChart.withSampleData() {
//     return new StackedAreaLineChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new charts.LineChart(seriesList,
//         defaultRenderer:
//             new charts.LineRendererConfig(includeArea: true, stacked: true),
//         animate: animate);
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<LinearSales, int>> _createSampleData() {
//     final myFakeDesktopData = [
//       new LinearSales(0, 5),
//       new LinearSales(1, 25),
//       new LinearSales(2, 100),
//       new LinearSales(3, 75),
//     ];

//     var myFakeTabletData = [
//       new LinearSales(0, 10),
//       new LinearSales(1, 50),
//       new LinearSales(2, 200),
//       new LinearSales(3, 150),
//     ];

//     var myFakeMobileData = [
//       new LinearSales(0, 15),
//       new LinearSales(1, 75),
//       new LinearSales(2, 300),
//       new LinearSales(3, 225),
//     ];

//     return [
//       new charts.Series<LinearSales, int>(
//         id: 'Desktop',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: myFakeDesktopData,
//       ),
//       new charts.Series<LinearSales, int>(
//         id: 'Tablet',
//         colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: myFakeTabletData,
//       ),
//       new charts.Series<LinearSales, int>(
//         id: 'Mobile',
//         colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: myFakeMobileData,
//       ),
//     ];
//   }
// }

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
