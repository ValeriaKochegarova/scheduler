import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/home/bottom_navigation_bar/bottom_navigation_bar.widget.dart';

import 'package:scheduler_app/screens/home/date_picker/date_picker.widger.dart';
import 'package:scheduler_app/screens/home/deals/deals.widget.dart';
import 'package:scheduler_app/screens/home/progress/progress.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double viewView = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('ДЕЛА ОК'),
              actions: <Widget>[
                DatePickerWidget(),
              ],
            ),
            body: GestureDetector(
              onTap: () {
                store.dispatch(UnselectDeal());
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.symmetric(
                    //     vertical: 10.0,
                    //   ),
                    //   child: Column(
                    //     children: <Widget>[
                    //       DatePickerWidget(),
                    //     ],
                    //   ),
                    // ),
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
