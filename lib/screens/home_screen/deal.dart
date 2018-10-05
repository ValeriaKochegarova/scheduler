import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deal extends StatelessWidget {
  final deal;
  final doneCb;
  final priorityColor;

  Deal(
      @required this.deal, @required this.doneCb, @required this.priorityColor);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white,),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.label,
              size: 17.0,
              color: priorityColor,
            ),
            Expanded(child: Text(deal['text'])),
            new CupertinoSwitch(
              value: deal['done'],
              onChanged: (bool value) {
                deal['done'] = value;
                doneCb(deal);
              },
            ),
          ],
        ));
  }
}
