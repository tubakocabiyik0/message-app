import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidgets extends StatelessWidget {
  String buttonText;
  Function pressed;
  Color color;
  Widget icon;

  ButtonWidgets(
      {@required this.buttonText,
      @required this.pressed,
      @required this.color,
      @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        onPressed: pressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
        color: color,
        elevation: 0,
      ),
    );
  }
}
