import 'package:flutter/material.dart';

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
              children:<Widget>[
                SizedBox(
                  height:height,
                  child: Stack(
                    children:<Widget>[
                      Positioned(
                        child: SizedBox(
                          width: width,
                          height: 350,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top:height * (6/ 100) ,
                                )
                              ],
                            ),
                          ),
                        )
                      )
                    ]
                  )
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
