import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deal extends StatelessWidget {
  var deal;
  final Function doneCb;
  final Color priorityColor;
  final int done;

  Deal(this.deal, this.doneCb, this.priorityColor, this.done);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xcc000000),
              offset: Offset(0.0, 2.0),
              blurRadius: 4.0,
            ),
            BoxShadow(
              color: const Color(0x80000000),
              offset: Offset(0.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.label,
              size: 17.0,
              color: priorityColor,
            ),
            Expanded(child: Text(deal['text'])),
            new Checkbox(
              value: done == 0 ? false : true,
              onChanged: (bool value) {
                Map updatedDeal = Map.from(deal)
                  ..addAll({'done': value ? 1 : 0});
                doneCb(updatedDeal);
              },
            )
          ],
        ));
  }
}
