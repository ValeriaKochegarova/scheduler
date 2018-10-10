import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/actions/calendar.action.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class CustomDatePickerWidget extends StatefulWidget {
  @override
  _CustomDatePickerWidgetState createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  DateTime _date = DateTime.now();

  Future<Null> _selectDate(BuildContext context, Function updateDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
      print('Date selected: ${_date.toString()}');
      updateDate(_date);
    }
  }

  List<String> _getDayHeaders(
      TextStyle headerStyle, MaterialLocalizations localizations) {
    final List<String> result = <String>[];
    for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      final String weekday = localizations.narrowWeekdays[i];
      result.add(weekday);
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) break;
    }
    return result;
  }

  List<int> _daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear) return 29;
      return 28;
    }
    return _daysInMonth[month - 1];
  }

  int _computeFirstDayOffset(
      int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = new DateTime(year, month).weekday - 1;
    // 0-based day of week, with 0 representing Sunday.
    final int firstDayOfWeekFromSunday = localizations.firstDayOfWeekIndex;
    // firstDayOfWeekFromSunday recomputed to be Monday-based
    final int firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the 1-st of the month.
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    var localization = MaterialLocalizations.of(context);
    DateTime currentDate = DateTime.now();
    currentDate = _date; //DateTime(currentDate.year, currentDate.month, 10);

    print('_date $_date');

    int monthStartDay = _computeFirstDayOffset(
        currentDate.year, currentDate.month, localization);
    final int daysInMonth = getDaysInMonth(currentDate.year, currentDate.month);
    final int currentDayOfWeek = (currentDate.day + monthStartDay - 1) % 7;
    final int daysAfterCurrentDate = 7 - 1 - currentDayOfWeek;
    int lastDay;
    final int newMonthOffset =
        daysAfterCurrentDate + currentDate.day - daysInMonth;
    final int firstDay = currentDate.day - currentDayOfWeek;
    if (newMonthOffset < 0) {
      lastDay = daysAfterCurrentDate + currentDate.day;
    } else {
      lastDay = currentDate.day;
    }
    List baseWeek = [];
    for (int i = firstDay < 1 ? 1 : firstDay; i <= lastDay; i++) {
      baseWeek.add(i);
    }

    if (newMonthOffset > 0) {
      for (int i = 1; i <= newMonthOffset; i++) {
        baseWeek.add(i);
      }
    }
    if (firstDay < 1) {
      var prevMonthLength =
          getDaysInMonth(currentDate.year, currentDate.month - 1);
      for (int i = prevMonthLength + firstDay, j = 0;
          i <= prevMonthLength;
          i++, j++) {
        baseWeek.insert(j, i);
      }
    }
    List<Widget> baseWeekWidgets = baseWeek.map((day) {
      if (currentDate.day == day) {
        return Center(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: new Border.all(
                    width: 5.0,
                    color: Colors.grey,
                  ),
                  color: Colors.grey,
                ),
                height: 40.0,
                width: 40.0,
                child: InkWell(
                    onTap: () {
                      print(111);
                    },
                    child: Center(child: Text(day.toString())))));
      }
      return Center(child: Text(day.toString()));
    }).toList();
    List<Widget> headerDaysWidget =
        _getDayHeaders(themeData.textTheme.caption, localization)
            .map((x) => Center(child: Text(x)))
            .toList();
    headerDaysWidget.addAll(baseWeekWidgets);

    return StoreConnector<AppState, Function>(converter: (store) {
      return (date) {
        store.dispatch(SelectDate(date));
        store.dispatch(GetDealsByDatePending());
      };
    }, builder: (context, updateDate) {
      return Expanded(
          child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context, updateDate);
                })
          ],
        ),
        Expanded(
            child:
                GridView.count(crossAxisCount: 7, children: headerDaysWidget))
      ]));
    });
  }
}
