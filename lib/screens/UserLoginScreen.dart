import 'package:flutter/material.dart';
import 'package:trashhub/screens/Viewreport.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/components/RoundedButton.dart';

class UserLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    width: MediaQuery.of(context).size.width * 0.4,
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
                    TextFormField(
                      decoration: kTextField,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: kTextField,
                    ),
                  ],
                ),
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
                    TextButton(
                      child: Text(
                        'Forget Password',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserLoginScreen()),
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
}
