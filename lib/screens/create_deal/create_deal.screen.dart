import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/common/widgets/bottom_navigation_bar/bottom_navigation_bar.widget.dart';
import 'package:scheduler_app/common/widgets/wrapper.widget.dart';
import 'package:scheduler_app/constants/strings/string_keys.dart';
import 'package:scheduler_app/screens/create_deal/colored_button/colored_pallet.dart';
import 'package:scheduler_app/screens/home/deals/deals.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';
import 'package:scheduler_app/utils/localization.dart';

class CreateDealScreen extends StatefulWidget {
  @override
  _CreateDealScreenState createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  final dateFormat = DateFormat("MM/d/yyyy 'at' h:mma");
  final now = DateTime.now();

  TextEditingController dealDateController = TextEditingController(
    text: store.state.selectedDeal == null
        ? ''
        : store.state.selectedDeal['text'],
  );

  num priority = getPriorityFilter(store.state) == null
      ? 0
      : getPriorityFilter(store.state);

  _getPriority() {
    this.setState(() {
      store.dispatch(SetPriorityFilter(this.priority));
    });
  }

  String text =
      store.state.selectedDeal == null ? '' : store.state.selectedDeal['text'];

  @override
  void initState() {
    store.dispatch(IsEditOn());
    super.initState();
  }

  @override
  void dispose() {
    dealDateController.dispose();
    store.dispatch(IsEditOff());
    super.dispose();
  }

  DateTime _date = store.state.date;

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(now.year, now.month, now.day),
        lastDate: DateTime(2070));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Localization.getString(Strings.deal),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: InkWell(
        onTap: () {
          hideKeyboard();
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment(1.0, 0.0),
            colors: [const Color(0xFF1A237E), const Color(0xFF7C4DFF)],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              WrapperWidget(
                  Column(
                    children: <Widget>[
                      Container(
                          child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                    border: new Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  controller: dealDateController,
                                  onChanged: (String text) {
                                    setState(() {
                                      this.text = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      // labelText: 'Что нужно сделать ?',
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      labelStyle: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20.0),
                                      border: InputBorder.none),
                                )),
                          ),
                          Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: IconButton(
                                iconSize: 35.0,
                                icon: Icon(Icons.calendar_today),
                                color: Colors.grey[800],
                                onPressed: () {
                                  _selectDate(context);
                                }),
                          ),
                        ],
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ColoredPallete(priority, (num priority) {
                            this.priority = priority;
                            this._getPriority();
                          }),
                          Text(_date.toString().substring(0, 11),
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black))
                        ],
                      ),
                    ],
                  ),
                  height: 150.0),
              Expanded(
                child: DealsWidget(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: StoreConnector<AppState, Map>(converter: (store) {
        return {
          'selectedDeal': store.state.selectedDeal,
          'createDeal': (deal) => store.dispatch(CreateDealPending(deal)),
          'unselectDeal': (deal) => store.dispatch(UnselectDeal()),
          'updateDeal': (deal) => store.dispatch(UpdateEditPending(deal)),
          'getDealsPending': () => store.dispatch(GetDealsByDatePending()),
        };
      }, builder: (context, state) {
        if (state['selectedDeal'] != null) {
          _getPriority;
        }
        return BottomNavigationWidget({
          'icon': Icons.cancel,
          'cb': () {
            Navigator.pop(context);
            store.dispatch(UnselectDeal());
          }
        }, {}, {
          'icon': Icons.check_circle_outline,
          'cb': text == ''
              ? null
              : () {
                  Map<String, dynamic> deal = {
                    'text': text,
                    'date': _date,
                    'priority': priority
                  };
                  if (state['selectedDeal'] == null) {
                    deal.addAll({'done': 0});
                    state['createDeal'](deal);
                    state['getDealsPending']();
                    store.dispatch(UnselectDeal());
                    return;
                  }
                  Map<String, dynamic> mappedDeal =
                      Map<String, dynamic>.from(state['selectedDeal']);
                  (mappedDeal).addAll(deal);
                  print(priority);
                  state['updateDeal'](mappedDeal);
                  state['getDealsPending']();
                  store.dispatch(UnselectDeal());
                },
        });
      }),
    );
  }
}
