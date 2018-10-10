import 'package:flutter/material.dart';
import 'package:scheduler_app/config/keys.dart';

class ColoredButtonWidget extends StatelessWidget {
  final priorityKey;
  final active;
  final Function cb;

  ColoredButtonWidget(this.active, this.priorityKey, this.cb);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => this.cb(priorityKey),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
                width: 30.0,
                height: 30.0,
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: active ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: PriorityColor[this.priorityKey],
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  width: 30.0,
                  height: 30.0,
                ))));
  }
}
