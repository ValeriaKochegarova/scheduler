import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/screens/create_deal/create_deal.screen.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DateTime>(converter: (store) {
      return store.state.date;
    }, builder: (context, date) {
      return isYesterday(date)
          ? Container(
              width: 0.0,
              height: 0.0,
            )
          : Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CreateDealScreen();
                          });
                    },
                  )
                ],
              ));
    });
  }
}
