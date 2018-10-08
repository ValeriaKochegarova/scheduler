import 'package:flutter/material.dart';

import 'package:scheduler_app/screens/home/date_picker/date_picker.widger.dart';
import 'package:scheduler_app/screens/home/deals/deals.widget.dart';
import 'package:scheduler_app/screens/home/page_route/page_route.widget.dart';
import 'package:scheduler_app/screens/home/progress/progress.widget.dart';
import 'package:scheduler_app/store/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double viewView = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Scheduler App'),
          backgroundColor: Color(0xFF01579B),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Column(
                  children: <Widget>[
                    DatePickerWidget(),
                    Divider(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: DonutPieChart(store.state.date),
                    height: viewView / 1.5,
                  ),
                  DealsWidget()
                ],
              ))
            ],
          ),
        ),
        persistentFooterButtons: <Widget>[
          FlatButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(NewDealPageRoute());
            },
          )
        ]);
  }
}
