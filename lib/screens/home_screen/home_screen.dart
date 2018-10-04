import 'package:flutter/material.dart';
import 'package:scheduler_app/screens/home_screen/deals.widget.dart';

class HomeScreen extends StatefulWidget {
 @override
 _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('text'),
     ),
     body: Container(
       padding: EdgeInsets.all(25.0),
       child: Center(child: DealsWidget()),
     ),
   );
 }
}
