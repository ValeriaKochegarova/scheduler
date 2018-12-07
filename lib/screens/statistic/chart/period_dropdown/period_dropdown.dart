import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/statistic/chart/period_dropdown/period_lable/period_label.widget.dart';
import 'package:scheduler_app/screens/statistic/chart/period_dropdown/period_select/period_select.dart';

class PeriodDropdownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[PeriodSelectWidget(), PeriodLabelWidget()],
    );
  }
}
