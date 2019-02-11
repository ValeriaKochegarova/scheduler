import 'package:flutter/material.dart';
import 'package:scheduler_app/common/widgets/bottom_navigation_bar/bottom_navigation_bar.widget.dart';
import 'package:scheduler_app/common/widgets/wrapper.widget.dart';
import 'package:scheduler_app/screens/statistic/chart/chart.widget.dart';
import 'package:scheduler_app/screens/statistic/period_checkbox/period_checkbox.dart';

class StatisticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Статистика',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment(1.0, 0.0),
                colors: [const Color(0xFF1A237E), const Color(0xFF7C4DFF)],
              )),
              child: Column(
                children: <Widget>[
                  WrapperWidget(PeriodCheckboxWidget()),
                  Expanded(child: WrapperWidget(GroupedFillColorBarChart()))
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationWidget({}, {}, {
              'icon': Icons.info_outline,
              'cb': () => Navigator.pushNamed(context, '/about')
            }));
  }
}
