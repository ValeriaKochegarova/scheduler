import 'package:flutter/material.dart';
import 'package:scheduler_app/common/widgets/bottom_navigation_bar/bottom_icon.widget/bottom_icon.widget.dart';

class BottomNavigationWidget extends StatelessWidget {
   final Map control1;
   final Map control2;
   final Map control3;

  
  BottomNavigationWidget(this.control1,this.control2, this.control3);

  @override
  Widget build(BuildContext context) {
      return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BottomIcon(800, control1['icon'], control1['cb']),
              BottomIcon( 800,control2['icon'], control2['cb']),
              BottomIcon(800, control3['icon'], control3['cb']),
            ],
          ));
  }
}

