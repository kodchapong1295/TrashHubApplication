import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/components/TextInputBox.dart';
import 'package:trashhub/Firebase.dart';
import 'package:provider/provider.dart';

class NGOsRegisterScreen extends StatefulWidget {
  @override
  _NGOsRegisterScreenState createState() => _NGOsRegisterScreenState();
}

class _NGOsRegisterScreenState extends State<NGOsRegisterScreen>
    with TickerProviderStateMixin {
  OverlayEntry overlayEntry;
  GlobalKey appBarKey = GlobalKey();
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation =
        Tween<double>(begin: 1.0, end: 1.0).animate(animationController);
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  TextEditingController orgName = TextEditingController();
  TextEditingController size = TextEditingController();
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
    showOverLay(status) async {
      OverlayState overlayState = Overlay.of(context);
      RenderBox renderBox = appBarKey.currentContext.findRenderObject();
      Offset offset = renderBox.localToGlobal(Offset.zero);

      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: offset.dy + renderBox.size.height,
          right: 0.0,
          left: 0.0,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Material(
              child: Opacity(
                opacity: animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      animationController.addListener(() {
        overlayState.setState(() {});
      });

      overlayState.insert(overlayEntry);
      animationController.forward();
      await Future.delayed(Duration(seconds: 2)).whenComplete(() {
        overlayEntry.remove();
        animationController.reverse();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        key: appBarKey,
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
                            if (_image != null) {
                              final imgUrl = await context
                                  .read<FlutterFireAuthService>()
                                  .uploadImageToFirebase(_image);
                              this.imgUrl = imgUrl;
                            } else {
                              this.imgUrl =
                                  "https://th.jobsdb.com/en-th/cms/employer/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png";
                            }
                            final status = await context
                                .read<FlutterFireAuthService>()
                                .signUpNGOs(
                                    email: email.text,
                                    password: password.text,
                                    orgname: orgName.text,
                                    size: size.text,
                                    imgUrl: imgUrl,
                                    context: context);
                            showOverLay(status);
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
