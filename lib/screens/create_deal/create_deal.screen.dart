import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/screens/create_deal/colored_button/colored_pallet.dart';
import 'package:scheduler_app/screens/create_deal/input/input.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';

class CreateDealScreen extends StatefulWidget {
  @override
  _CreateDealScreenState createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  final dateFormat = DateFormat("MM/d/yyyy 'at' h:mma");
  final now = DateTime.now();

  final dealDateController = TextEditingController();

  num priority = 0;
  String text = '';

  @override
  void dispose() {
    dealDateController.dispose();
    super.dispose();
  }

  DateTime _date = store.state.date;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(now.year, now.month, now.day),
        lastDate: DateTime(2019));

    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, Map>(converter: (store) {
      return {
        'selectedDeal': store.state.selectedDeal,
        'createDeal': (deal) =>
            store.dispatch(CreateDealPending(Map.from(deal))),
        'unselectDeal': (deal) => store.dispatch(UnselectDeal()),
      };
    }, builder: (context, state) {
      if (state['selectedDeal'] != null) {
        priority = state['selectedDeal']['priority'];
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: NewDealInput(
                      'Что нужно сделать ?',
                      1,
                      (String text) {
                        setState(() {
                          this.text = text;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 10.0),
                    child: IconButton(
                        iconSize: 35.0,
                        icon: Icon(Icons.calendar_today),
                        color: Colors.grey[800],
                        onPressed: () {
                          _selectDate(context);
                        }),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ColoredPallete(priority, (num priority) {
                this.priority = priority;
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                iconSize: 35.0,
                disabledColor: Colors.grey[400],
                icon: Icon(Icons.check_circle_outline),
                color: Colors.green,
                onPressed: text == ''
                    ? null
                    : () {
                        Map deal = {
                          'text': text,
                          'done': 0,
                          'date': _date.toString(),
                          'priority': priority
                        };
                        state['createDeal'](deal);
                        store.dispatch(GetDealsByDatePending());
                      },
                padding: const EdgeInsets.all(8.0),
              ),
              IconButton(
                iconSize: 35.0,
                icon: Icon(Icons.cancel),
                color: Colors.red[700],
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        ],
      );
    }));
  }
}
