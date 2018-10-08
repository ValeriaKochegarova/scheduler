import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deal extends StatelessWidget {
  final deal;
  final Function doneCb;
  final Color priorityColor;
  final bool done;

  Deal(this.deal, this.doneCb, this.priorityColor, this.done);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          // borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.label,
              size: 17.0,
              color: priorityColor,
            ),
            Expanded(child: Text(deal['text'])),
            new Switch(
              value: done,
              onChanged: (bool value) {
                deal['done'] = value;
                doneCb(deal);
              },
            )
            // new CupertinoSwitch(
            //   value: a,
            //   onChanged: (value) {
            //     // a = value;
            //     doneCb(deal);
            //   },
            // ),
          ],
        ));
  }
}
