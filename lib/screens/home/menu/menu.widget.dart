import 'package:flutter/material.dart';
import 'package:scheduler_app/common/widgets/wrapper.widget.dart';
import 'package:scheduler_app/screens/home/date_picker/date_picker.widger.dart';
import 'package:scheduler_app/screens/home/deals_filter_with_statistic/deals_filter_with_statistic.widget.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        DatePickerWidget(),
        WrapperWidget(
          DealsFilterWithStatistic(),
          height: 80.0,
        )
      ],
    ));
  }
}
