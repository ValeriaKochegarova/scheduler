import 'package:flutter/material.dart';

class NewDealInput extends StatelessWidget {
  final Function changeCb;
  final String initialText;
  final int maxLines;

  NewDealInput(
    this.initialText,
    this.maxLines,
    this.changeCb,
  );

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      initialValue: initialText,
      onFieldSubmitted: changeCb,
      );
    
    
    //  TextField(
    //   maxLines: maxLines,
    //   onChanged: changeCb,
    //   decoration: InputDecoration(
    //     labelText: labelText,
    //     fillColor: Colors.white,
    //     filled: true,
    //     // contentPadding: EdgeInsets.only(right: 10.0),
    //     labelStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
    //     border: InputBorder.none
    //     // border: OutlineInputBorder(
    //     //     borderRadius: BorderRadius.all(Radius.circular(0.0)),
    //     //     borderSide: BorderSide(color: Colors.grey)),
    //   ),
    //);
    // return FormField(
    //   initialValue: ,
    //   builder: ,
    //   )
  }
}
