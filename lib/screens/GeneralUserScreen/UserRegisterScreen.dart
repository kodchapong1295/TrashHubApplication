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
                        TextInputBox(
                          controller: firstname,
                          title: "Firstname",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextInputBox(
                          controller: lastname,
                          title: "Lastname",
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
                          obscureText: true,
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
                            if (_image != null) {
                              final imgUrl = await context
                                  .read<FlutterFireAuthService>()
                                  .uploadImageToFirebase(_image);
                              this.imgUrl = imgUrl;
                            } else {
                              this.imgUrl =
                                  "https://th.jobsdb.com/en-th/cms/employer/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png";
                            }

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

class TextInputBox extends StatelessWidget {
  const TextInputBox(
      {Key key,
      @required this.controller,
      @required this.title,
      this.obscureText,
      this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool obscureText;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText == null ? false : obscureText,
      controller: controller,
      validator: validator == null
          ? (text) {
              if (text == null || text.isEmpty) {
                return 'Text is empty';
              }
              return null;
            }
          : validator,
      decoration: kTextField.copyWith(hintText: title),
    );
  }
}
