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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              centerTitle: true,
              title: Text(
                'Ежедневник',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                store.dispatch(UnselectDeal());
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment(1.0, 0.0),
                  colors: [const Color(0xFF01579B), const Color(0xFF00B8D4)],
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
                  'from':
                      DateTime(DateTime.now().year, DateTime.now().month, 1),
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
            })));
  }
}
