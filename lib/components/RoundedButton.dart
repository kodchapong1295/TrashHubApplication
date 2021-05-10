import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class RoundedButton extends StatelessWidget {
  String title;
  Color btnColor;
  Color textColor;
  Function onPressed;

  RoundedButton({this.title, this.btnColor, this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kPrimaryColor;
      }
      return kPrimaryColor;
    }

    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
      ),
    );
  }
}
