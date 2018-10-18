import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Change theme'),
              Checkbox(
                value: true,
              )
            ],
          )
        ],
      ),
    ));
  }
}
