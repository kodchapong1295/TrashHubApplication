import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

import 'package:trashhub/screens/GeneralUserScreen/UserLoginScreen.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserRegisterScreen.dart';
import 'package:trashhub/screens/NGOsScreen/NGOProfile.dart';
import 'package:trashhub/screens/NGOsScreen/NGOsLoginScreen.dart';
import 'package:trashhub/screens/NGOsScreen/NGOsRegisterScreen.dart';

import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'NGOsScreen/ViewReportNGO.dart';

import 'package:provider/provider.dart';
import 'package:trashhub/Firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenMenu extends StatelessWidget {
  Future<bool> isUser(context) async {
    final temp = await (context).read<FlutterFireAuthService>().isUser();
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return firebaseUser != null
        ? FutureBuilder<String>(future: Future<String>.sync(() async {
            final isUser =
                await (context).read<FlutterFireAuthService>().isUser();

            if (isUser) {
              return "User";
            }
            return "NGO";
          }), builder: (ctx, auth) {
            print(auth);
            if (auth.hasData) {
              if (auth.data == "User") {
                return UserProfileScreen();
              } else {
                return NGOProfileScreen();
              }
            } else {
              return Scaffold(
                body: SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Image.asset('images/logo.png'),
                              width: 184,
                            ),
                            Text(
                              'TRASH HUB',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            Text(
                              'Trash Problem Notifier',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RoundedButton(
                                title: "LOG IN",
                                btnColor: kPrimaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserLoginScreen()),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RoundedButton(
                                title: "SIGN UP",
                                btnColor: kPrimaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserRegisterScreen()),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Login as NGOs',
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NGOsLoginScreen()),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Do not press it !!!!',
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NGOProfileScreen()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          })
        : Scaffold(
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Image.asset('images/logo.png'),
                          width: 184,
                        ),
                        Text(
                          'TRASH HUB',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          'Trash Problem Notifier',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RoundedButton(
                            title: "LOG IN",
                            btnColor: kPrimaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserLoginScreen()),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RoundedButton(
                            title: "SIGN UP",
                            btnColor: kPrimaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserRegisterScreen()),
                              );
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Login as NGOs',
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NGOsLoginScreen()),
                              );
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Do not press it !!!!',
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NGOProfileScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    // if (firebaseUser != null) {
    //   print(firebaseUser);
    //   print('User has already logged in');
    //   return UserProfileScreen();
    // }
    // return
  }
}
