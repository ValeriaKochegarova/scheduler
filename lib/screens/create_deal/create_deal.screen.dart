import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
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
  var priority;

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
      return  Column(
        mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: NewDealInput(
                        controller: dealNameController,
                        labelText: 'Enter Deal Name',
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      'Select the priority',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    DropdownButton<String>(
                      items: <String>['0', '1', '2'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        priority = value;
                        return priority;
                      },
                    ),
                    IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          if (dealNameController.text != '') {
                            var dealData = {
                              'text': dealNameController.text,
                              'done': 0,
                              'date': store.state.date,
                              'priority': priority
                            };
                            store.dispatch(CreateDealPending(dealData));
                          }
                        },
                        color: Colors.blueGrey[900],
                        padding: const EdgeInsets.all(8.0),
                      ),
                  ],
                );
    }));
  }
}
