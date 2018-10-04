import 'package:flutter/cupertino.dart';

class Deal extends StatelessWidget {
  final deal;
  final doneCb;

  Deal(@required this.deal, @required this.doneCb);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: Text(deal['text'])),
        new CupertinoSwitch(
          value:  deal['done'],
          onChanged: (bool value) {
            deal['done'] = value;
            doneCb(deal);
          },
        ),
      ],
    );
  }
}
