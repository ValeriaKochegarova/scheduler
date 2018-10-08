import 'package:flutter/material.dart';
import 'package:scheduler_app/config/keys.dart';

class RoundChartPainter extends CustomPainter {
  double completePercent;
  double radius;

  RoundChartPainter(
      {this.completePercent,
      this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.grey[200]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    Paint complete = new Paint()
      ..color = this.completePercent < 40
          ? PriorityColor[0]
          : this.completePercent >= 40 && this.completePercent < 70
              ? PriorityColor[1]
              : PriorityColor[2]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    Offset center = new Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * 3.14 * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        -3.14 / 2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
