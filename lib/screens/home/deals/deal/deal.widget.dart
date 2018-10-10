import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_app/common/widgets/wrapper.widget.dart';
import 'package:scheduler_app/config/keys.dart';

class Deal extends StatelessWidget {
  Map deal;
  final Function doneCb;
  final bool unactive;

  Deal(this.deal, this.doneCb, this.unactive);

  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      Row(
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
      ),
      color: PriorityColor[deal['priority']],
    );
  }
}
