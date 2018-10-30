import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_app/common/widgets/wrapper.widget.dart';
import 'package:scheduler_app/config/keys.dart';

class Deal extends StatelessWidget {
  Map deal;
  final Function doneCb;
  final Function editCb;
  final Function removeCb;
  final bool isYesterday;
  final bool isTomorrow;

  Deal(this.deal, this.isYesterday, this.isTomorrow, this.doneCb, this.editCb,
      this.removeCb);

  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          isYesterday || isTomorrow
              ? Container(width: 20.0,)
              : Checkbox(
                  value: deal['done'] == 0 ? false : true,
                  onChanged: (bool value) {
                    Map<String, dynamic> mappedDeal =
                        Map<String, dynamic>.from(deal);
                    mappedDeal..addAll({'done': value ? 1 : 0});
                    doneCb(mappedDeal);
                  }),
          Expanded(child: Text(deal['text'])),
          isYesterday
              ? Container()
              : PopupMenuButton(
                  onSelected: (action) {
                    action == 'Редактировать'
                        ? this.editCb(this.deal)
                        : this.removeCb(this.deal);
                  },
                  itemBuilder: (BuildContext context) {
                    return ['Удалить', 'Редактировать'].map((choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
        ],
      ),
      height: 60.0,
      color: PriorityColor[deal['priority']],
    );
  }
}
