import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_app/config/keys.dart';

class Deal extends StatelessWidget {
  Map deal;
  final Function doneCb;
  final bool unactive;

  Deal(this.deal, this.doneCb, this.unactive);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: PriorityColor[deal['priority']], width: 4.0)),
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
            Checkbox(
                value: deal['done'] == 0 ? false : true,
                onChanged: unactive
                    ? null
                    : (bool value) {
                        Map updatedDeal = Map.from(deal)
                          ..addAll({'done': value ? 1 : 0});
                        doneCb(updatedDeal);
                      }),
            Expanded(child: Text(deal['text'])),
          ],
        ));
  }
}
