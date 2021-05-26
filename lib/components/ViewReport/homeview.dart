import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: Row(
                    children: <Widget>[
                      Text(trip.title, style: new TextStyle(fontSize: 24.0)),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Text(trip.text),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
