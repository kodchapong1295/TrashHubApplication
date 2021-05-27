import 'package:flutter/material.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'Trip.dart';
import 'package:trashhub/constants.dart';

class CustomeDialog extends StatelessWidget {
  final String title, description, button;

  CustomeDialog({this.title, this.description, this.button});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: RoundedButton(
                  title: "Accept",
                  btnColor: kPrimaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
