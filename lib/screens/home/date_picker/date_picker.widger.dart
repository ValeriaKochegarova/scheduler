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
      return Calendar(
        onDateSelected: (date) {
          state['selectDate'](date);
          state['getDeals']();
        },
      );
    });
  }
}
