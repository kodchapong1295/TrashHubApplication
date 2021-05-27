import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/screens/NGOsScreen/NGOsRegisterScreen.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/components/TextInputBox.dart';
import 'package:trashhub/Firebase.dart';
import 'package:provider/provider.dart';

class NGOsLoginScreen extends StatefulWidget {
  @override
  _NGOsLoginScreenState createState() => _NGOsLoginScreenState();
}

class _NGOsLoginScreenState extends State<NGOsLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () => {Navigator.of(context).pop(false)},
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.89,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextInputBox(
                          controller: email,
                          title: "Email",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextInputBox(
                          controller: password,
                          title: "Password",
                          obscureText: true,
                        ),
                      ],
                    ),
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
                          if (_formKey.currentState.validate()) {
                            await context
                                .read<FlutterFireAuthService>()
                                .signInNGOs(
                                    email: email.text,
                                    password: password.text,
                                    context: context);
                          }
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Register as NGOs',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NGOsRegisterScreen()),
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
      ),
    );
  }
}
