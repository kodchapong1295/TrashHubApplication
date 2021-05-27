import 'package:flutter/material.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'Trip.dart';
import 'package:trashhub/constants.dart';

class CustomeDialog extends StatelessWidget {
  final String topic, title, description, button, location, date;

  final String no;

  CustomeDialog(
      {this.topic,
      this.description,
      this.button,
      this.no,
      this.date,
      this.title,
      this.location});
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          height: height * .6,
          padding: EdgeInsets.only(
            top: 35,
            bottom: 16,
            left: 6,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: width,
                child: Text(
                  topic,
                  style: TextStyle(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No    : " + no.toString(),
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Date : " + date,
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Location : " + location,
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Description :",
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 110),
              Align(
                alignment: Alignment.center,
                child: RoundedButton(
                  title: "Accept",
                  btnColor: kPrimaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
