import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/common/utils/date.pipe.dart';
import 'package:scheduler_app/screens/create_deal/create_deal_input.dart';
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
            title: Text('Create new deal', style: TextStyle(fontSize: 40.0)),
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
                    Container(child: NewDealInput(
                      controller: dealNameController,
                      labelText: 'Enter Deal Name',
                      maxLines: 1,
                    ),),
                      ButtonTheme(
                      minWidth: 370.0,
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(dealNameController.text != '') {
                          var date = formatDate(DateTime.now());
                          var dealData = {
                            'id': 1,
                            'dealName': dealNameController.text,
                            'date': date,
                          };
                          print(dealData);
                          // store.dispatch(CreateDealPending(dealData));
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
                ),)
            ],
          )
        );
      }
    ));
  }
}