import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/screens/home/bottom_navigation_bar/bottom_icon.widget/bottom_icon.widget.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'date': store.state.date,
      };
    }, builder: (context, state) {
      return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BottomIcon(800, Icons.show_chart, () {
                Navigator.pushNamed(context, '/statistic');
              }),
              BottomIcon(
                  800,
                  Icons.add_circle_outline,
                  isYesterday(state['date'])
                      ? null
                      : () {
                          Navigator.pushNamed(context, '/create');
                        }),
              BottomIcon(800, Icons.info_outline, () {
                Navigator.pushNamed(context, '/about');
              }),
            ],
          ));
    });
  }
}
