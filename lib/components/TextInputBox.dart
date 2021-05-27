import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class TextInputBox extends StatelessWidget {
  const TextInputBox(
      {Key key,
      @required this.controller,
      @required this.title,
      this.obscureText,
      this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool obscureText;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText == null ? false : obscureText,
      controller: controller,
      validator: validator == null
          ? (text) {
              if (text == null || text.isEmpty) {
                return 'Text is empty';
              }
              return null;
            }
          : validator,
      decoration: kTextField.copyWith(hintText: title),
    );
  }
}
