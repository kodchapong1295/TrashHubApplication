import 'package:flutter/material.dart';

import '../../constants.dart';

class ButtomButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Widget screen;
  final Icon icon;
  const ButtomButton(
      {Key key, this.onPressed, this.screen, this.label, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.15,
        child: ElevatedButton.icon(
          icon: icon,
          label: Text(label),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            onPrimary: Colors.white,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          onPressed: screen == null
              ? onPressed
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen),
                  );
                },
        ));
  }
}
