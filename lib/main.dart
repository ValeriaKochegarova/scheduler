import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/database/database.helper.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/home/home.screen.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:redux/redux.dart';
import 'package:scheduler_app/store/store.dart';

void main() async {
  var db = DatabaseHelper();
  await db.initDb();
  runApp(SchedulerApp(
    store: store,
  ));
}

class SchedulerApp extends StatelessWidget {
  final Store<AppState> store;
  SchedulerApp({Key key, this.store}) : super(key: key) {
    this.store.dispatch(GetDealsByDatePending());
  }
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Дела Ok',
          navigatorKey: NavKeys.navKey,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Avenir'),
          home: HomeScreen(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('ru', 'RU'),
          ],
        ));
  }
}
