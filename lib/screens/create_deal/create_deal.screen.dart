import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/config/keys.dart';
import 'package:scheduler_app/screens/create_deal/colored_button/colored_button.dart';
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

  final dealNameController = TextEditingController();
  num priority = 0;

  @override
  void dispose() {
    dealNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, Function>(converter: (store) {
      return;
    }, builder: (context, createDeal) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: NewDealInput(
              controller: dealNameController,
              labelText: 'Что нужно сделать ?',
              maxLines: 1,
            ),
          ),
          Text(
            'Выберите приоритет:',
            style: TextStyle(fontSize: 16.0),
          ),
          ColoredPallete((num priority) {
            this.priority = priority;
          }),
          IconButton(
            iconSize: 30.0,
            disabledColor: Colors.grey[400],
            icon: Icon(Icons.check_circle_outline),
            onPressed: dealNameController.text == ''
                ? null
                : () {
                    Map dealData = {
                      'text': dealNameController.text,
                      'done': 0,
                      'date': store.state.date,
                      'priority': priority
                    };
                    print(dealData);
                    store.dispatch(CreateDealPending(Map.from(dealData)));
                  },
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      );
    }));
  }
}
