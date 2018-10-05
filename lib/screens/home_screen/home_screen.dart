import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/screens/home_screen/deals.widget.dart';
import 'package:scheduler_app/screens/home_screen/progressBar.widget.dart';

import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:scheduler_app/store/actions/calendar.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double viewView = MediaQuery.of(context).size.width;
    return Container(
        child: StoreConnector<AppState, Map>(converter: (store) {
      return;
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Scheduler App'),
            backgroundColor: Color(0xFF01579B),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: new EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 10.0,
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Calendar(
                        onDateSelected: (date) {
                          store.dispatch(SelectDate(date));
                        },
                      ),
                      new Divider(
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
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                ))
              ],
            ),
          ));
    }));
  }
}
