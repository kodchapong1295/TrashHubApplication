import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  //
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yosathor Penga',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        Text('total report')
                      ],
                    ),
                  )
                ]),
              ),
              Text(
                'TRASH HUB',
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
