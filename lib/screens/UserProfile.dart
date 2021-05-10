import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ButtomButton(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: ProfileInfo(),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: kPrimaryColor,
                        textStyle: TextStyle(
                          fontSize: 18,
                        )),
                    onPressed: () {},
                    icon: Icon(Icons.room_rounded),
                    label: Text('View Requests Status')),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'Request History',
                  style: TextStyle(color: kPrimaryColor, fontSize: 24),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RequestHistoryList(),
              RequestHistoryList()
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      //
      Expanded(
        flex: 3,
        child: Container(
          child: Image.asset('images/logo.png'),
          width: 70,
          height: 70,
        ),
      ),
      Expanded(
        flex: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yosathorn Penga',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Total report : 5',
                style: TextStyle(color: kPrimaryColor, fontSize: 18))
          ],
        ),
      )
    ]);
  }
}

class ButtomButton extends StatelessWidget {
  const ButtomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.15,
        child: ElevatedButton.icon(
          icon: Icon(Icons.camera_alt_rounded),
          label: Text('NEW REQUEST'),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            onPrimary: Colors.white,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            print('Pressed');
          },
        ));
  }
}

class RequestHistoryList extends StatelessWidget {
  const RequestHistoryList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
      height: 125.0,
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 130.0,
            color: Colors.red,
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 130.0,
            color: Colors.blue,
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 130.0,
            color: Colors.green,
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 130.0,
            color: Colors.yellow,
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 130.0,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
