import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/common/widgets/wrapper.widget.dart';
import 'package:scheduler_app/store/actions/calendar.action.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';
import 'package:scheduler_app/common/helpers/date.helper.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _date = DateTime.now();

  Future<Null> _selectDate(BuildContext context, Function updateDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2016),
        lastDate: DateTime(2070));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
      store.dispatch(UnselectDeal());
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

  int _computeFirstDayOffset(
      int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
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
    DateTime currentDate = _date;
    int monthStartDay = _computeFirstDayOffset(
        currentDate.year, currentDate.month, localization);
    String monthWithYear = localization.formatMonthYear(currentDate);
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
      lastDay = daysInMonth;
    }
    List baseWeek = [];
    for (int i = firstDay < 1 ? 1 : firstDay; i <= lastDay; i++) {
      baseWeek.add(
          {'day': i, 'date': DateTime(currentDate.year, currentDate.month, i)});
    }

    if (newMonthOffset > 0) {
      for (int i = 1; i <= newMonthOffset; i++) {
        baseWeek.add({
          'day': i,
          'date': DateTime(currentDate.year, currentDate.month + 1, i)
        });
      }
    }
    if (firstDay < 1) {
      var prevMonthLength = getDaysInMonth(currentDate.year, currentDate.month);
      for (int i = prevMonthLength + firstDay, j = 0;
          i <= prevMonthLength;
          i++, j++) {
        baseWeek.insert(j, {
          'day': i,
          'date': DateTime(currentDate.year, currentDate.month - 1, i)
        });
      }
    }
    List<Widget> baseWeekWidgets(updateDate) => baseWeek.map((date) {
          if (currentDate.day == date['day']) {
            return Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 5.0,
                        color: Colors.indigoAccent,
                      ),
                      color: Colors.indigoAccent,
                    ),
                    height: 40.0,
                    width: 40.0,
                    child: Center(
                        child: Text(
                      date['day'].toString(),
                      style: TextStyle(color: Colors.white),
                    ))));
          }

          return Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 5.0,
                      color: Colors.transparent,
                    ),
                  ),
                  height: 40.0,
                  width: 40.0,
                  child: InkWell(
                      onTap: () {
                        updateDate(date['date']);
                      },
                      child: Center(
                          child: Text(date['day'].toString(),
                              style: TextStyle(color: Colors.black))))));
        }).toList();

    List<Widget> headerDaysWidget(updateDate) {
      List<Widget> headerDays =
          _getDayHeaders(themeData.textTheme.caption, localization)
              .map((x) => Center(child: Text(x, style: TextStyle(color: Colors.black),)))
              .toList();
      headerDays.addAll(baseWeekWidgets(updateDate));
      return headerDays;
    }

    return StoreConnector<AppState, Function>(converter: (store) {
      return (date) {
        store.dispatch(SelectDate(date));
        store.dispatch(GetDealsByDatePending());
      };
    }, builder: (context, updateDate) {
      return WrapperWidget(Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.today),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    _date = DateTime.now();
                  });
                  store.dispatch(UnselectDeal());
                  updateDate(_date);
                }),
            Text(monthWithYear, style: TextStyle(color: Colors.black)),
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context, updateDate);
                })
          ],
        ),
        GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            children: headerDaysWidget((date) {
              setState(() {
                _date = date;
              });
              store.dispatch(UnselectDeal());
              updateDate(date);
            })),
      ]));
    });
  }
}
