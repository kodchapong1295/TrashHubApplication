import 'package:flutter/material.dart';
import 'package:trashhub/Firebase.dart';
import 'package:trashhub/components/ViewReport/CustomDialog.dart';
import 'package:provider/provider.dart';
import 'package:trashhub/models/Report.dart';
import 'Trip.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future reports;
  @override
  void initState() {
    reports = getReports();
    super.initState();
  }

  Future<List<Report>> getReports() async {
    final List<Report> reports =
        await (context).read<FlutterFireAuthService>().getWaitingReports();
    return reports;
  }

  final List<Trip> tripsList = [];

  List<Trip> buildListTrip(List<Report> reports) {
    List<Trip> list = [];
    reports.forEach((element) {
      list.add(Trip(
          id: element.id,
          date: element.date,
          description: element.description,
          imgUrl: element.imgUrl,
          location: element.location));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: reports,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          // print(snapshot.data);
          final List<Trip> list = buildListTrip(snapshot.data);
          // print(list);
          return Container(
            child: new ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildTripCard(context, index, list),
            ),
          );
        });
  }

  Widget buildTripCard(BuildContext context, int index, List<Trip> list) {
    // print(list[1].location);
    final trip = list[index];
    return new Container(
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => CustomeDialog(
                    topic: "Request Details",
                    no: trip.id,
                    date: trip.date,
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
                          child: Image.network(trip.imgUrl),
                          width: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  trip.location,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  trip.date,
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
