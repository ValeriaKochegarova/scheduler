import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/screens/create_deal/create_deal.screen.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';

class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'date': store.state.date,
        'selectedDeal': store.state.selectedDeal,
      };
    }, builder: (context, state) {
      return isYesterday(state['date'])
          ? Container(
              width: 0.0,
              height: 0.0,
            )
          : state['selectedDeal'] != null
              ? Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.delete_forever),
                        color: Colors.red,
                        onPressed: () {
                          store.dispatch(
                              DeleteDealPending(state['selectedDeal']));
                          //TODO: should to be in epic
                          store.dispatch(UnselectDeal());
                        },
                      ),
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return CreateDealScreen();
                              });
                        },
                      )
                    ],
                  ))
              : Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
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
