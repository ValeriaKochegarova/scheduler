import 'package:flutter/material.dart';

class BottomIcon extends StatelessWidget {
  final int intense;
  final Function onPressedCb;
  final IconData icon;

  BottomIcon(this.intense, this.icon, this.onPressedCb);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40.0,
      color: Colors.grey[intense],
      icon: Icon(icon),
      onPressed: () {
        onPressedCb();
      },
    );
  }
}
