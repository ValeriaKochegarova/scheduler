import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  AppBarWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFf9fcfc),
      iconTheme: IconThemeData(color: Colors.grey),
      title: Text(
        this.title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
