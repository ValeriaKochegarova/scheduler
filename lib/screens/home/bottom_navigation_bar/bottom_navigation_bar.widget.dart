import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/screens/home/bottom_navigation_bar/bottom_icon.widget/bottom_icon.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'date': store.state.date,
        'selectedDeal': store.state.selectedDeal,
        'unselectDeal': () => store.dispatch(UnselectDeal()),
        'getDealsByDate': () => store.dispatch(GetDealsByDatePending()),
        'deleteDeal': (deal) => store.dispatch(DeleteDealPending(deal)),
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
                        color: Colors.grey[800],
                        onPressed: () {
                          state['deleteDeal'](state['selectedDeal']);
                          //TODO: should to be in epic
                          state['unselectDeal']();
                          state['getDealsByDate']();
                        },
                      ),
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.edit),
                        color: Colors.grey[800],
                        onPressed: () {
                          Navigator.pushNamed(context, '/create');
                        },
                      )
                    ],
                  ))
              : Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      BottomIcon(400, Icons.show_chart, () {}),
                      BottomIcon(800, Icons.add_circle_outline, () {
                          Navigator.pushNamed(context, '/create');
                        }),
                      BottomIcon(800, Icons.settings, () {
                          Navigator.pushNamed(context, '/settings');
                        }),
                    ],
                  ));
    });
  }
}
