import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/components/TextInputBox.dart';
import 'package:trashhub/Firebase.dart';
import 'package:provider/provider.dart';

class NGOsRegisterScreen extends StatefulWidget {
  @override
  _NGOsRegisterScreenState createState() => _NGOsRegisterScreenState();
}

class _NGOsRegisterScreenState extends State<NGOsRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  TextEditingController orgName = TextEditingController();
  TextEditingController size = TextEditingController();

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
                        'Thanks for being our partner',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextInputBox(
                          controller: orgName,
                          title: "Organization Name",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextInputBox(
                          controller: size,
                          title: "Size of organization",
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextInputBox(
                          controller: confirmpass,
                          obscureText: true,
                          title: "Confirm password",
                          validator: (text) {
                            if (text == null || text.isEmpty)
                              return 'Text is empty';
                            if (text != password.text)
                              return 'Password did not match';
                            return null;
                          },
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
                        title: "REGISTER",
                        btnColor: kPrimaryColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await context
                                .read<FlutterFireAuthService>()
                                .signUpNGOs(
                                    email: email.text,
                                    password: password.text,
                                    orgname: orgName.text,
                                    size: size.text,
                                    context: context);
                          }
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
