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

class _NGOsLoginScreenState extends State<NGOsLoginScreen>
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
                            final status = await context
                                .read<FlutterFireAuthService>()
                                .signInNGOs(
                                    email: email.text,
                                    password: password.text,
                                    context: context);
                            showOverLay(status);
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
