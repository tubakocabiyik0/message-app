import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidgets extends StatelessWidget {
  String _buttonText;
  Function _pressed;
  Color _color;
  Widget icon;

  ButtonWidgets(this._buttonText, this._pressed, this._color, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        onPressed: _pressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Text(_buttonText),
              ),
            ),
          ],
        ),
        color: _color,
        elevation: 0,
      ),
    );
  }
}
