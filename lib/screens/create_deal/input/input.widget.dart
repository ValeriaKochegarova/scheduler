import 'package:flutter/material.dart';

class NewDealInput extends StatelessWidget {
  NewDealInput(
      {@required this.controller,
      @required this.labelText,
      @required this.maxLines});

  final controller;
  final labelText;
  final maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyle(fontStyle: FontStyle.italic),
        // border: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(0.0)),
        //     borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
