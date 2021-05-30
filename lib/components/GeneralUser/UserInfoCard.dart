import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    Key key,
    @required this.userInfo,
  }) : super(key: key);

  final Future userInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userInfo,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final result = snapshot.data;

          return Row(children: [
            SizedBox(
              height: 110,
            ),
            //
            Expanded(
              flex: 3,
              child: Container(
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(result.imgUrl),
                  backgroundColor: Colors.transparent,
                ),
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
                    '${result.firstname} ${result.lastname}',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Total report : ${(result.totalReport)}',
                      style: TextStyle(color: kPrimaryColor, fontSize: 18))
                ],
              ),
            )
          ]);
        });
  }
}
