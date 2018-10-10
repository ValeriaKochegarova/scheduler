import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/screens/home/bottom_navigation_bar/bottom_navigation_bar.widget.dart';

import 'package:scheduler_app/screens/home/deals/deals.widget.dart';
import 'package:scheduler_app/screens/home/progress/progress.widget.dart';
import 'package:scheduler_app/store/actions/calendar.action.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _date = store.state.date;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
      print('Date selected: ${_date.toString()}');

      store.dispatch(SelectDate(_date));
      store.dispatch(GetDealsByDatePending());
      print(store.state.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    var date = store.state.date;
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    double viewView = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.calendar_today),
                        color: Color(0xcc000000),
                        onPressed: () {
                          _selectDate(context);
                        }),
                  ],
                )
              ],
            ),
            body: GestureDetector(
              onTap: () {
                store.dispatch(UnselectDeal());
              },
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(top: 10.0),
                      child: Text(formattedDate, style: TextStyle(fontSize: 20.0)),
                    ),
                    Expanded(
                        child: ListView(
                      children: <Widget>[
                        Container(
                          child: DonutPieChart(),
                          height: viewView / 1.5,
                        ),
                        DealsWidget()
                      ],
                    )),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationWidget()));
  }
}
