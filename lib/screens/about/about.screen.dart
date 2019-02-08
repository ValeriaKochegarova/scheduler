import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'О приложении',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Дела OK v1.0.0', style: TextStyle(fontSize: 35.0))),
          Text('@2018 JSDaddy', style: TextStyle(fontSize: 25.0)),
        ],
      )),
    );
  }
}
