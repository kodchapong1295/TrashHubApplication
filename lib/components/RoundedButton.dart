import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String title;
  Color btnColor;
  Color textColor;

  RoundedButton({this.title, this.btnColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: null,
        child: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return btnColor;
              return btnColor; // Use the component's default.
            },
          ),
        ),
      ),
    );
  }
}
