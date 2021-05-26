import 'package:trashhub/screens/AuthenMenu.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/Firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
      providers: [
        Provider<FlutterFireAuthService>(
          create: (_) => FlutterFireAuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FlutterFireAuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'FlutterFire Provider Template',
        home: MaterialApp(
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
        ),
      ),
    );
  }
}
