import 'package:flutter/material.dart';

import '../constants.dart';
import '../constants.dart';

class ViewReport extends StatefulWidget {
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
               SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left:15),
                          width: width * 0.15,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: kPrimaryColor),
                              onPressed: () =>
                                  Navigator.of(context).pop(false))),
                      SizedBox(
                        width: width * 0.13,
                      ),
                      Text(
                        "Request Status",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Alef-Regular',
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
