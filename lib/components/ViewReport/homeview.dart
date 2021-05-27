import 'package:flutter/material.dart';
import 'package:trashhub/components/ViewReport/CustomDialog.dart';
import 'Trip.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Trip> tripsList = [
    Trip(7779, "Best is God", DateTime.now(), "Ratchasima District, Nakhon",
        "There are many Best around there."),
    Trip(7779, "Best is God", DateTime.now(), "Ratchasima District, Nakhon",
        "There are many Best around there."),
    Trip(7779, "Best is God", DateTime.now(), "Ratchasima District, Nakhon",
        "There are many Best around there."),
    Trip(7779, "Best is God", DateTime.now(), "Ratchasima District, Nakhon",
        "There are many Best around there."),
    Trip(7779, "Best is God", DateTime.now(), "Ratchasima District, Nakhon",
        "There are many Best around there."),
    Trip(7779, "Best is God", DateTime.now(), "Ratchasima District, Nakhon",
        "There are many Best around thereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee."),
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
