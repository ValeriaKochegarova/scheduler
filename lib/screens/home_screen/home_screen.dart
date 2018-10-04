import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/home_screen/deals.widget.dart';
import 'package:scheduler_app/screens/home_screen/painter.dart';
import 'package:scheduler_app/screens/home_screen/progressBar.widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scheduler App'),
          backgroundColor: Color(0xFF01579B),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: DonutPieChart()),
            Expanded(child: DealsWidget())
          ],
        ));
  }
}
