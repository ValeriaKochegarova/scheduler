import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/home_screen/deals.widget.dart';
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
          title: Text('text'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  DonutPieChart(),
                  Positioned(
                    left: 150.0,
                    top: 100.0,
                    child: Text(
                      'Monday 30 \n 0%',
                      textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
            Expanded(child: DealsWidget())
          ],
        ));
  }
}
