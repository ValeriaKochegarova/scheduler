import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';

class DealsWidget extends StatefulWidget {
  @override
  _DealsWidgetState createState() => _DealsWidgetState();
}

class _DealsWidgetState extends State<DealsWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List>(converter: (store) {
      return store.state.deals;
    }, builder: (context, delas) {
      return ListView(
        children: delas.map<Widget>((deal) {
          return ListTile(title: Text(deal['text']));
        }).toList(),
      );
    });
  }
}
