import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/screens/home_screen/home_screen.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

import 'package:scheduler_app/store/store.dart';

void main() async{
  runApp(SchedulerApp(
    // store: store,
  ));
}

class SchedulerApp extends StatelessWidget {
  // final Store<AppState> store;
  // SchedulerApp({Key key, this.store}) : super(key: key) {}
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Scheduler App',
          // navigatorKey: NavKeys.navKey,
          theme:
              ThemeData(primarySwatch: Colors.blue, fontFamily: 'Avenir'),
          home: HomeScreen(),
          // routes: <String, WidgetBuilder>{
          //   '/create': (BuildContext context) => CreateDealScreen(),
          // },
        ));
  }
}
