import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/home/bottom_navigation_bar/bottom_icon.widget/bottom_icon.widget.dart';
import 'package:scheduler_app/screens/statistic/chart/chart.widget.dart';

class StatisticScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color(0xFFf9fcfc),
              iconTheme: IconThemeData(color: Colors.grey),
              title: Text(
                'Статистика',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          child: Text('Месяц'),
                        ),
                        RaisedButton(
                          onPressed: () {},
                          child: Text('Год'),
                        ),
                      ],
                    )),
                Expanded(child: GroupedFillColorBarChart.withSampleData())
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  BottomIcon(800, Icons.multiline_chart, () {}),
                  BottomIcon(800, Icons.pie_chart, () {}),
                  BottomIcon(800, Icons.info_outline, () {
                    Navigator.pushNamed(context, '/about');
                  })
                ],
              ),
            )));
  }
}
