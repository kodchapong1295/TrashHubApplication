import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/Firebase.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatelessWidget {
  String email;
  String password;
  String firstname;
  String lastname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () => {Navigator.of(context).pop(false)},
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome!',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Thanks for saving the world with us',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onChanged: (fn) => {this.firstname = fn},
                      decoration: kTextField.copyWith(hintText: 'Firstname'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (ln) => {this.lastname = ln},
                      decoration: kTextField.copyWith(hintText: 'Lastname'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (email) => {this.email = email},
                      decoration: kTextField.copyWith(hintText: 'Email'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (password) => {this.password = password},
                      decoration: kTextField.copyWith(hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // onChanged: (password) => {this.password = password},
                      decoration:
                          kTextField.copyWith(hintText: 'Confirm Password'),
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
                      title: "REGISTER",
                      btnColor: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        context.read<FlutterFireAuthService>().signUp(
                            email: email,
                            password: password,
                            firstname: firstname,
                            lastname: lastname,
                            context: context);
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
