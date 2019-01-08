import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/helpers/database.helper.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/about/about.screen.dart';
import 'package:scheduler_app/screens/create_deal/create_deal.screen.dart';
import 'package:scheduler_app/screens/home/home.screen.dart';
import 'package:scheduler_app/screens/statistic/statistic.screen.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/actions/statistic_control.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:redux/redux.dart';
import 'package:scheduler_app/store/store.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DatabaseHelper().initDb();
  runApp(SchedulerApp(
    store: store,
  ));
}

class SchedulerApp extends StatelessWidget {
  final Store<AppState> store;
  SchedulerApp({Key key, this.store}) : super(key: key) {
    // store.dispatch(CreateDealPending( Map<String, dynamic>.from({
    //                         'text': 'Прошлое дело ',
    //                         'date': DateTime(2017,11,29),
    //                         'priority': 1
    //                       })));

    store.dispatch(GetDealsByDatePending());
    store.dispatch(GetStartOfStatisticPeriodPending());
  }
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('ru', 'RU'),
              //const Locale('en', 'EN'),
            ],
            title: 'Дела Ok',
            navigatorKey: NavKeys.navKey,
            theme: ThemeData(
              primaryColor: Color(0xFFf9fcfc),
              accentColor: Colors.grey,
              fontFamily: 'Avenir',
              iconTheme: IconThemeData(color: Colors.grey[800]),
            ),
            home: HomeScreen(),
            routes: <String, WidgetBuilder>{
              '/create': (BuildContext context) => CreateDealScreen(),
              '/about': (BuildContext context) => AboutScreen(),
              '/statistic': (BuildContext context) => StatisticScreen(),
            }));
  }
}
