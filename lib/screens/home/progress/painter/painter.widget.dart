import 'package:flutter/material.dart';

class RoundChartPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  double radius;


  RoundChartPainter(
      {this.lineColor, this.completeColor, this.completePercent, this.width, this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    //double radius = size.width / 2.0; //, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * 3.14 * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -3.14 / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
