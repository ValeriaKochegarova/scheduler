import 'package:flutter/material.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/create_deal/colored_button/colored_button.dart';

class ColoredPallete extends StatefulWidget {
  final Function cb;
  final num priority;
  ColoredPallete(this.priority, this.cb);

  @override
  ColoredPalleteState createState() =>
      ColoredPalleteState(this.priority, this.cb);
}

class ColoredPalleteState extends State<ColoredPallete> {
  num priority;
  final Function cb;
  ColoredPalleteState(this.priority, this.cb);

  void _changePriority(priority) {
    setState(() {
      this.priority = priority;
      this.cb(priority);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: PriorityColor.keys
            .toList()
            .map<Widget>((num priorityKey) => ColoredButtonWidget(
                priority == priorityKey, priorityKey, this._changePriority))
            .toList());
  }
}
