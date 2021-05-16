import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textformfield extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget icon;
  final errorText;
  final String initialValue;
  Textformfield({
    this.icon,
    this.labelText,
    this.obscureText,
    this.controller,
    this.errorText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
          decoration: InputDecoration(

            errorText: errorText,
            prefixIcon: icon,
            filled: true,
            fillColor: Colors.grey.shade200,
            labelText: labelText,
          ),
          obscureText: obscureText,
          controller: controller
      );
  }
}