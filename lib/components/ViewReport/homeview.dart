import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final List<String> tripsList = ["New York", "Boston", "Bangkok", "BangCare"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: tripsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(index.toString()),
                  Text(tripsList[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
