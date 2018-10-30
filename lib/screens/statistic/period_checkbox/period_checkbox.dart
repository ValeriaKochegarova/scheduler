import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/actions/statistic_control.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class PeriodCheckboxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'period': store.state.statisticControl,
        'setPeriod': (int period) => period == 0
            ? store.dispatch(SetMonthPeriod())
            : store.dispatch(SetYearPeriod())
      };
    }, builder: (context, state) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () => state['setPeriod'](0),
                  child: Container(
                    width: 70.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: state['period']['type'] == 0
                            ? Colors.grey
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0))),
                    child: Center(child: Text('Mecяц')),
                  )),
              InkWell(
                  onTap: () => state['setPeriod'](1),
                  child: Container(
                    width: 70.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: state['period']['type'] == 1
                            ? Colors.grey
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    child: Center(child: Text('Год')),
                  )),
            ],
          ));
    });
  }
}
