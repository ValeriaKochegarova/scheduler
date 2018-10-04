import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/home_screen/delas.widget.dart';
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
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: Text(
                        'SURVEY ANSWERS',
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      // chart
                    ),
                    Container(
                        height: 180.0, child: DonutPieChart.withSampleData())
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: DealsWidget()
            ),
          ),
        ],
      ),
    );
  }
}
