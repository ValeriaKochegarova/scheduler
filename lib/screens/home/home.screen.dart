import 'package:flutter/material.dart';
import 'package:scheduler_app/common/widgets/bottom_navigation_bar/bottom_navigation_bar.widget.dart';
import 'package:scheduler_app/screens/home/deals/deals.widget.dart';
import 'package:scheduler_app/screens/home/menu/menu.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/store.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Ежедневник',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                store.dispatch(UnselectDeal());
              },
              child: Container(
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
              'cb': () => Navigator.pushNamed(context, '/statistic')
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
