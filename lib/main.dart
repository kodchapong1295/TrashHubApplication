import 'package:flutter/material.dart';
import 'package:trashhub/screens/AuthenMenu.dart';
import 'package:trashhub/screens/UserProfile.dart';
import 'package:trashhub/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primaryColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
          bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: kPrimaryColor,
          ),
        ),
      ),
      home: AuthenMenu(),
    );
  }
}
