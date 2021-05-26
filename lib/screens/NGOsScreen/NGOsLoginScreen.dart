import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/Firebase.dart';

class NGOsLoginScreen extends StatelessWidget {
  String email;
  String password;

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
                    'NGOs',
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
                      onPressed: () async {
                        UserCredential user =
                            await signInWithEmailAndPassword(email, password);
                        if (user != null) {
                          print(user);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileScreen()),
                          );
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NGOsLoginScreen()),
                          );
                        }
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Forget Password',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        print('Forgot Password');
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
