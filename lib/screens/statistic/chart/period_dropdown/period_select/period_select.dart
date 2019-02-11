import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/actions/statistic_period.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/statistic_period.selector.dart';

class PeriodSelectWidget extends StatelessWidget {
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
        'dropdownList': getStisitcControl(store.state),
        'period': store.state.statisticControl['type'],
        'setStatisticPeriod': (period) =>
            store.dispatch(SetPeriodPending(period)),
      };
    }, builder: (context, state) {
      return PopupMenuButton(
        icon: Icon(Icons.date_range, color: Colors.black,),
        onSelected: (period) {
          state['setStatisticPeriod'](period);
        },
        itemBuilder: (BuildContext context) {
          return List<Map<String, dynamic>>.from(state['dropdownList'])
              .map((Map<String, dynamic> date) {
            String valueForRender =
                _convertLable(state['period'], date, localization);
            return PopupMenuItem(
              value: date,
              child: Text(valueForRender, style: TextStyle(color: Colors.black),),
            );
          }).toList();
        },
      );

    });
  }
}
