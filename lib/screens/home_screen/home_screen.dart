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
          title: Text('Scheduler App'),
          backgroundColor: Color(0xFF01579B),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                child: DonutPieChart(),
              ),
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment(1.0, 0.0),
                          colors: [
                            const Color(0xFF01579B),
                            const Color(0xFF00B8D4)
                          ],
                        ),
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 2.0))),
                    child: DealsWidget())),
          ],
        ));
  }
}
