import 'package:flutter/material.dart';
import 'package:scheduler_app/common/widgets/bottom_navigation_bar/bottom_navigation_bar.widget.dart';
import 'package:scheduler_app/common/widgets/wrapper.widget.dart';
import 'package:scheduler_app/screens/statistic/chart/chart.widget.dart';
import 'package:scheduler_app/screens/statistic/period_checkbox/period_checkbox.dart';

class StatisticScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Статистика',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(
              children: <Widget>[
                WrapperWidget(PeriodCheckboxWidget()),
                Expanded(child: WrapperWidget(GroupedFillColorBarChart()))
              ],
            ),
            bottomNavigationBar: BottomNavigationWidget({}, {}, {
              'icon': Icons.info_outline,
              'cb': () => Navigator.pushNamed(context, '/about')
            })));
  }
}