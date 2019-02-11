import 'package:flutter/material.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/home/deals_filter_with_statistic/RoundChart/painter/painter.widget.dart';

class RoundChartWidget extends StatelessWidget {
  final int all;
  final int done;

  RoundChartWidget(this.done, this.all);

  Widget build(BuildContext context) {
    double viewView = MediaQuery.of(context).size.width;
    double percentage = all == 0 ? 0.0 : done / all * 100;

    return Container(
      height: viewView / 5.0,
      width: viewView / 5.0,
      child: CustomPaint(
        foregroundPainter: RoundChartPainter(
            completePercent: percentage, radius: 30),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${percentage.round()}%',
                style: TextStyle(
                    color: percentage < 40
                        ? PriorityColor[0]
                        : percentage >= 40 && percentage < 70
                            ? PriorityColor[1]
                            : PriorityColor[2],
                    fontSize: 16.0),
              ),
            )),
      ),
    );
  }
}
