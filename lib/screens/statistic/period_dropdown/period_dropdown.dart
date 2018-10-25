import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/selectors/statistic_period.selector.dart';

class PeriodDropdownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localization = MaterialLocalizations.of(context);

    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'dropdownList': getStisitcPeriodDate(store.state),
        'period': store.state.statisticPeriod,
      };
    }, builder: (context, state) {
      print('======> $state');
      return DropdownButton<String>(
        hint: Text('A'),
        items:
            (List<DateTime>.from(state['dropdownList'])).map((DateTime date) {
          String valueForRender = state['period']['type'] == 1
              ? '${date.year} г.'
              : localization.formatMonthYear(date);
          return DropdownMenuItem<String>(
            value: valueForRender,
            child: Text(valueForRender),
          );
        }).toList(),
        onChanged: (_) {},
      );
    });
  }
}
