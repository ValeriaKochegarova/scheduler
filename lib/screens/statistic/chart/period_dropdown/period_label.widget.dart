import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class PeriodLabelWidget extends StatelessWidget {
  _convertLable(int period, date, localization) {
    return period == 1
        ? '${date['lable'].year} г.'
        : localization.formatMonthYear(date['lable']);
  }

  @override
  Widget build(BuildContext context) {
    var localization = MaterialLocalizations.of(context);

    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'periodType': store.state.statisticControl['type'],
        'period': store.state.statisticPeriod
      };
    }, builder: (context, state) {
      String valueForRender =
          _convertLable(state['periodType'], state['period'], localization);
      return Text(valueForRender);
    });
  }
}
