import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/home/bottom_navigation_bar/bottom_navigation_bar.widget.dart';
import 'package:scheduler_app/screens/home/deals/deals.widget.dart';
import 'package:scheduler_app/screens/home/menu/menu.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/store.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            body: GestureDetector(
              onTap: () {
                store.dispatch(UnselectDeal());
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    MenuWidget(),
                    Expanded(
                      child: ListView(
                      children: <Widget>[DealsWidget()],
                    )),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationWidget()));
  }
}
