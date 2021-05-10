import 'package:flutter/material.dart';
import 'package:trashhub/screens/Viewreport.dart';

class AuthenMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset('images/logo.png'),
                    width: 184,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Test',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Text("Test to view request na ai sus"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewReport()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
