import 'package:flutter/material.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/constants.dart';

class DialogShowStatus extends StatelessWidget {
  final String topic,
      title,
      description,
      button,
      location,
      date,
      status,
      responsible_by;

  final String id;

  DialogShowStatus(
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
                          "Id    : ",
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
                          status,
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
                      "Responsible NGO :",
                      style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      responsible_by,
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
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
            ],
          ),
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          //   Container(
          //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //     width: 150,
          //     child: RoundedButton(
          //       title: "Okay",
          //       btnColor: kPrimaryColor,
          //       textColor: Colors.white,
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //   ),
          // ])
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: 100,
          child: TextButton(
            child: Text("Okay",
                style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Widget dialogContent(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          height: height * 0.6,
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
          child: SingleChildScrollView(
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
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Id    : ",
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
                            status,
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
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 100),
                          width: 150,
                          child: RoundedButton(
                            title: "Okay",
                            btnColor: kPrimaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
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
        ),
      ],
    );
  }
}
