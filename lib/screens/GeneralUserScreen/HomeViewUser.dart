import 'package:flutter/material.dart';
import 'package:trashhub/components/ViewReport/CustomDialog.dart';
import 'package:trashhub/components/ViewReport/Trip.dart';

class HomeViewUser extends StatefulWidget {
  @override
  _HomeViewUserState createState() => _HomeViewUserState();
}

class _HomeViewUserState extends State<HomeViewUser> {
  final List<Trip> tripsList = [
    Trip(7779, "God Nut", DateTime.now(), "God Nut Home",
        "There are many Nut around there."),
    Trip(7779, "God Nut", DateTime.now(), "God Nut Home",
        "There are many Nut around there."),
    Trip(7779, "God Nut", DateTime.now(), "God Nut Home",
        "There are many Nut around there."),
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
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => CustomeDialog(
                    topic: "Request Details",
                    no: trip.no.toString(),
                    date: trip.date.toString().split(" ")[0],
                    location: trip.location,
                    description: trip.description,
                  ));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 5, bottom: 20, left: 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset('images/logo.png'),
                          width: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  trip.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  trip.date.toString().split(" ")[0],
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
      ),
    );
  }
}
