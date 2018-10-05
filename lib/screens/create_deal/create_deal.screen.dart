import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/screens/create_deal/create_deal_input.dart';
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
      return Scaffold(
          backgroundColor: Color(0xFFDD3D3D3),
          appBar: AppBar(
            title: Text('Create new deal', style: TextStyle(fontSize: 32.0)),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                color: Color(0xFFDD3D3D3),
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text('Create New Deal',
                              style: TextStyle(fontSize: 25.0)),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
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
                      // onChanged: () {},
                    ),
                    ButtonTheme(
                      minWidth: 370.0,
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (dealNameController.text != '') {
                            var dealData = {
                              'id': store.state.deals.length + 1,
                              'text': dealNameController.text,
                              'done': false,
                              'date': store.state.date,
                              'priority': 1
                            };
                            print(dealData);
                            store.dispatch(CreateDealPending(dealData));
                          }
                        },
                        textColor: Colors.white,
                        color: Colors.blueGrey[900],
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ADD DEAL",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    }));
  }
}
