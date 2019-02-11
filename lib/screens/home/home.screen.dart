import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/helpers/date.helper.dart';
import 'package:scheduler_app/common/widgets/bottom_navigation_bar/bottom_navigation_bar.widget.dart';
import 'package:scheduler_app/screens/home/deals/deals.widget.dart';
import 'package:scheduler_app/screens/home/menu/menu.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/actions/statistic_period.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Text(
                      'Ежедневник',
                      style: TextStyle(color: Colors.white),
                    )),
                IconButton(
                  icon: Icon(Icons.color_lens),
                  onPressed: changeBrightness,
                ),
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.language), onPressed: () {}))
              ],
            )),
        body: GestureDetector(
          onTap: () {
            store.dispatch(UnselectDeal());
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(1.0, 0.0),
              colors: [const Color(0xFF1A237E), const Color(0xFF7C4DFF)],
            )),
            child: Column(
              children: <Widget>[
                MenuWidget(),
                Expanded(
                  child: DealsWidget(),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationWidget({
          'icon': Icons.show_chart,
          'cb': () {
            StoreProvider.of<AppState>(context).dispatch(SetPeriodPending({
              'lable': DateTime.now(),
              'from': DateTime(DateTime.now().year, DateTime.now().month, 1),
              'to': DateTime(DateTime.now().year, DateTime.now().month,
                  getDaysInMonth(DateTime.now().year, DateTime.now().month))
            }));
            Navigator.pushNamed(context, '/statistic');
          }
        }, {
          'icon': Icons.add_circle_outline,
          'cb': () => Navigator.pushNamed(context, '/create')
          // isYesterday(state['date'])
          //     ? null
          //     :
        }, {
          'icon': Icons.info_outline,
          'cb': () => Navigator.pushNamed(context, '/about')
        }));
  }
}
