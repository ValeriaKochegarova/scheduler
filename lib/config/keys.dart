import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavKeys {
  static final navKey = new GlobalKey<NavigatorState>();
}

const Map<int, Color> PriorityColor = {
  1: Colors.red,
  2: Colors.orange,
  3: Colors.green,
};

const Map<int, bool> NumToBool = {0: false, 1: true};
