import 'package:flutter/material.dart';
import 'package:trashhub/screens/AuthenMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color mainColor = Color(0xff2ba58a);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primaryColor: mainColor,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
          bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: mainColor,
          ),
        ),
      ),
      home: AuthenMenu(),
    );
  }
}
