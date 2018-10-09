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

  num priority = 0;
  String text = '';

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
          Text(
            'Выберите приоритет:',
            style: TextStyle(fontSize: 16.0),
          ),
          ColoredPallete(priority, (num priority) {
            this.priority = priority;
          }),
          IconButton(
            iconSize: 30.0,
            disabledColor: Colors.grey[400],
            icon: Icon(Icons.check_circle_outline),
            onPressed: text == ''
                ? null
                : () {
                    Map deal = {
                      'text': text,
                      'done': 0,
                      'date': store.state.date,
                      'priority': priority
                    };
                    state['createDeal'](deal);
                  },
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      );
    }));
  }
}
