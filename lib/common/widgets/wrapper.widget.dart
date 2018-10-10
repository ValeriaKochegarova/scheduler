import 'package:flutter/material.dart';

class WrapperWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  WrapperWidget(this.child, {this.color = Colors.white, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 4.0)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xcc000000),
              offset: Offset(0.0, 2.0),
              blurRadius: 4.0,
            ),
            BoxShadow(
              color: const Color(0x80000000),
              offset: Offset(0.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(5.0),
        child: child);
  }
}
