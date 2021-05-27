import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/Firebase.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatefulWidget {
  @override
  _UserRegisterScreenState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  File _image;
  final picker = ImagePicker();
  String imgUrl;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
                        'Thanks for saving the world with us',
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
                        _image == null
                            ? Container(
                                width: 100,
                                height: 100,
                                child: MaterialButton(
                                  onPressed: getImage,
                                  color: kPrimaryColor,
                                  textColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  shape: CircleBorder(),
                                ),
                              )
                            : Container(
                                width: 100.0,
                                height: 100.0,
                                child: MaterialButton(
                                  onPressed: getImage,
                                  shape: CircleBorder(),
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(_image))),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: firstname,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Text is empty';
                            }
                            return null;
                          },
                          decoration:
                              kTextField.copyWith(hintText: 'Firstname'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: lastname,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Text is empty';
                            }
                            return null;
                          },
                          decoration: kTextField.copyWith(hintText: 'Lastname'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: email,

                          // onChanged: (email) => {this.email = email},
                          decoration: kTextField.copyWith(hintText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Text is empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Text is empty';
                            }
                            return null;
                          },
                          decoration: kTextField.copyWith(hintText: 'Password'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: confirmpass,
                          validator: (text) {
                            if (text == null || text.isEmpty)
                              return 'Text is empty';
                            if (text != password.text)
                              return 'Password did not match';
                            return null;
                          },
                          decoration:
                              kTextField.copyWith(hintText: 'Confirm Password'),
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
                            final imgUrl = await context
                                .read<FlutterFireAuthService>()
                                .uploadImageToFirebase(_image);
                            this.imgUrl = imgUrl;
                            await context
                                .read<FlutterFireAuthService>()
                                .signUpUser(
                                    email: email.text,
                                    password: password.text,
                                    firstname: firstname.text,
                                    lastname: lastname.text,
                                    imgUrl: imgUrl,
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
