import 'package:flutter/material.dart';
import 'package:trashhub/Firebase.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'Trip.dart';
import 'package:trashhub/constants.dart';

import 'package:provider/provider.dart';

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
            top: 20,
            bottom: 0,
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
                    Row(
                      children: [
                        Text(
                          "ID    : ",
                          style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          no.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          "Date : ",
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Location : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Description :",
                      style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
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
              SizedBox(height: 90),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        width: 110,
                        child: RoundedButton(
                          title: "Cancel",
                          btnColor: Colors.white,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Center(
                      child: Container(
                        width: 110,
                        child: RoundedButton(
                          title: "Accept",
                          btnColor: kPrimaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            (context)
                                .read<FlutterFireAuthService>()
                                .ngoAcceptReport(no);
                            Navigator.pop(context);
                            // Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
