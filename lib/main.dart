import 'package:flutter/material.dart';
import 'package:trashhub/screens/AuthenMenu.dart';
import 'package:trashhub/screens/UserProfile.dart';
import 'package:trashhub/constants.dart';

import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('ERROR');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
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

        // Otherwise, show something whilst waiting for initialization to complete
        // return Loading();
      },
    );
  }
}
