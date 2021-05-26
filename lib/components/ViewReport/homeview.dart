import 'package:flutter/material.dart';
import 'Trip.dart';

class HomeView extends StatelessWidget {
  final List<Trip> tripsList = [
    Trip("Cheigmai", "This is Cheigmai"),
    Trip("Tonlor", "This is Tonlor"),
    Trip("Bangcare", "This is Cheigmai"),
    Trip("Ratchapreuk", "This is Cheigmai"),
    Trip("Ratchapreuk", "This is Cheigmai"),
    Trip("Ratchapreuk", "This is Cheigmai"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: tripsList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildTripCard(context, index),
      ),
    );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final trip = tripsList[index];
    return new Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 20, left: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset('images/logo.png'),
                        width: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                trip.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Container(
                              child: Text(
                                trip.text,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      )
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
