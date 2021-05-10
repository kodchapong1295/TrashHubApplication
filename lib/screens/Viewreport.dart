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
              children: <Widget>[
                SizedBox(
                    height: height,
                    child: Stack(children: <Widget>[
                      Container(
                          child: SizedBox(
                        width: width,
                        height: 170,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: height * (9 / 100),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: new EdgeInsets.only(right: 45),
                                      width: width * 0.2,
                                      child: IconButton(
                                        icon: Icon(Icons.arrow_back,
                                            color: Colors.green),
                                        onPressed: () =>
                                            {Navigator.of(context).pop(false)},
                                      ),
                                    ),
                                    Text(
                                      'ตากผ้าแปบ',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 24,
                                          fontFamily: 'Open-Sans'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
