import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/screens/create_deal/colored_button/colored_pallet.dart';
import 'package:scheduler_app/screens/create_deal/input/input.widget.dart';
import 'package:scheduler_app/store/actions/deals.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/store/store.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateDealScreen extends StatefulWidget {
  @override
  _CreateDealScreenState createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  final dateFormat = DateFormat("MM/d/yyyy 'at' h:mma");

  final noteDateController = TextEditingController();

  num priority = 0;
  String text = '';

  @override
  void dispose() {
    noteDateController.dispose();
    super.dispose();
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
          Text('Выберите дату:'),
          Theme(
            data: Theme.of(context).copyWith(
                primaryColor: Colors.blue,
                textSelectionColor: Colors.blue,
                toggleableActiveColor: Colors.blue),
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey[900])),
              child: DateTimePickerFormField(
                controller: noteDateController,
                format: dateFormat,
                onChanged: (noteDate) {
                  print(noteDate);
                },
              ),
            ),
          ),
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
                      'date': noteDateController.text,
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
