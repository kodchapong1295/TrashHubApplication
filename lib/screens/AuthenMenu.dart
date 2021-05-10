import 'package:flutter/material.dart';
import 'package:trashhub/screens/Viewreport.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/components/RoundedButton.dart';

class AuthenMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                      title: "SIGN UP",
                      btnColor: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Text("Test to view request na ai sus"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewReport()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
