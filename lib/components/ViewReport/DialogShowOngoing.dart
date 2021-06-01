import 'package:flutter/material.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/constants.dart';
import 'package:provider/provider.dart';
import 'package:trashhub/Firebase.dart';

class DialogShowOngoing extends StatelessWidget {
  final String topic,
      title,
      description,
      button,
      location,
      date,
      status,
      responsible_by;

  final String id;

  DialogShowOngoing(
      {this.topic,
      this.responsible_by,
      this.description,
      this.button,
      this.id,
      this.date,
      this.title,
      this.status,
      this.location});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      scrollable: true,
      title: Text(
        topic,
        style: TextStyle(
          fontSize: 24,
          color: kPrimaryColor,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      // backgroundColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "ID: ",
                          style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          id.toString(),
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
                    Row(
                      children: [
                        Text(
                          "Status : ",
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${status[0].toUpperCase()}${status.substring(1)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 7,
                    // ),
                    // Text(
                    //   "Responsible NGO :",
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       color: kPrimaryColor,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: 7,
                    // ),
                    // Text(
                    //   responsible_by == "" ? "None" : responsible_by,
                    //   style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    // ),
                    // SizedBox(
                    //   height: 7,
                    // ),
                    Text(
                      "Location : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
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
                      description == "" ? "None" : description,
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: 120,
          child: RoundedButton(
            title: "Complete",
            btnColor: kPrimaryColor,
            textColor: Colors.white,
            onPressed: () async {
              await (context)
                  .read<FlutterFireAuthService>()
                  .ngoCompleteReport(id);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
