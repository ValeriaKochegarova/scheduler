import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/actions/calendar.action.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class DatePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'selectDate': (DateTime date) => store.dispatch(SelectDate(date)),
        'getDeals': () => store.dispatch(GetDealsByDatePending())
      };
    }, builder: (context, state) {
      return Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xcc000000),
                offset: Offset(0.0, 2.0),
                blurRadius: 4.0,
              ),
              BoxShadow(
                color: const Color(0x80000000),
                offset: Offset(0.0, 1.0),
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Calendar(
            onDateSelected: (date) {
              state['selectDate'](date);
              state['getDeals']();
            },
          ));
    });
  }
}
