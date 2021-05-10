import 'package:flutter/material.dart';
import 'package:trashhub/screens/AuthenMenu.dart';
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
<<<<<<< HEAD
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
=======
          fontFamily: 'Open Sans',
          primaryColor: kPrimaryColor,
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor))),
>>>>>>> 36569d592d0ba6ef5ba6321a47829ce198f9d5a7
      home: AuthenMenu(),
    );
  }
}
