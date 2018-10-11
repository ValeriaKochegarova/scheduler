import 'package:flutter/material.dart';

class NewDealInput extends StatelessWidget {
  final Function changeCb;
  final String labelText;
  final int maxLines;

  NewDealInput(
    this.labelText,
    this.maxLines,
    this.changeCb,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      onChanged: changeCb,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.white,
        filled: true,
        // contentPadding: EdgeInsets.only(right: 10.0),
        labelStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
        border: InputBorder.none
        // border: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(0.0)),
        //     borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
