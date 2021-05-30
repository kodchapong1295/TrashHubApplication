import 'package:flutter/material.dart';

import '../../constants.dart';

class MyRequestsCard extends StatelessWidget {
  const MyRequestsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        'My Reports',
        style: TextStyle(
            color: kPrimaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
}
