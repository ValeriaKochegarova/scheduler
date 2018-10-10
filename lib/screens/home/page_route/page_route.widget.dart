import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/create_deal/create_deal.screen.dart';

class NewDealPageRoute extends PageRouteBuilder {
  final Widget widget;
  NewDealPageRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: CreateDealScreen(),
          );
        });
}
