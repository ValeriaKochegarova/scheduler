import 'package:flutter/material.dart';
import 'package:scheduler_app/config/keys.dart';

class RoundChartPainter extends CustomPainter {
  List<double> completePercent;
  double radius;
  double stroke = 8.0;

  RoundChartPainter({this.completePercent, this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = Colors.grey[200]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    Paint complete = Paint()
      ..color = Colors.grey[200]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    Offset center = Offset(size.width / 2, size.height / 2);
    for (int i = 0, j = 0; i < completePercent.length; i++) {
      if (completePercent[i].isNaN) {
        continue;
      }
      canvas.drawCircle(center, radius - j * (stroke + 2), line);
      double arcAngle = 2 * 3.14 * (completePercent[i]);
      complete.color = PriorityColor[i];
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius - j * (stroke + 2)),
          -3.14 / 2,
          arcAngle,
          false,
          complete);
      j++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
