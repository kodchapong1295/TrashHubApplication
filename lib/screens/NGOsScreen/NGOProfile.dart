import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/components/DialogShowStatus.dart';
import 'package:trashhub/components/ViewReport/DialogShowOngoing.dart';
import 'package:trashhub/constants.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trashhub/models/NGO.dart';
import 'package:provider/provider.dart';
import 'package:trashhub/Firebase.dart';
import 'package:trashhub/models/Report.dart';
import 'package:trashhub/screens/AuthenMenu.dart';
import 'package:trashhub/screens/NGOsScreen/ViewReportNGO.dart';

List<Widget> buildImageSliders(
    List<Report> reports, BuildContext context, Function refresh) {
  print(reports);
  return reports
      .map((r) => Container(
            child: GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (context) => DialogShowOngoing(
                          topic: "Request Details",
                          id: r.id,
                          date: r.date,
                          status: r.status,
                          location: r.location,
                          description: r.description,
                          responsible_by: r.responsible_by,
                        )).then((value) => refresh());
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(r.imgUrl,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                            fit: BoxFit.cover),
                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(0, 0, 0, 0),
                                  r.status == 'completed'
                                      ? Color.fromARGB(200, 50, 205, 50)
                                      : r.status == 'ongoing'
                                          ? Color.fromARGB(200, 255, 165, 0)
                                          : Color.fromARGB(200, 255, 25, 0),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Tap For Details",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  r.status == 'completed'
                                      ? Color.fromARGB(200, 50, 205, 50)
                                      : r.status == 'ongoing'
                                          ? Color.fromARGB(200, 255, 165, 0)
                                          : Color.fromARGB(200, 255, 25, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Row(
                              children: [
                                r.status == 'completed'
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 40.0,
                                      )
                                    : r.status == 'ongoing'
                                        ? Icon(
                                            Icons.flag_outlined,
                                            color: Colors.white,
                                            size: 40.0,
                                          )
                                        : Icon(
                                            Icons.hourglass_empty,
                                            color: Colors.white,
                                            size: 40.0,
                                          ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    '${r.location.split(',').first.length >= 21 ? r.location.split(',').first.substring(0, 21) + "..." : r.location.split(',').first}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ))
      .toList();
}

List<Widget> buildSeeMoreSliders(List<Report> reports, BuildContext context) {
  print(reports);
  return reports
      .map((r) => Column(
            children: [
              Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 45,
                    child: TextButton.icon(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: kPrimaryColor,
                            textStyle: TextStyle(
                              fontSize: 18,
                            )),
                        onPressed: null,
                        icon: Icon(Icons.info_outline),
                        label: Text('See More')),
                  ),
                ),
              ),
            ],
          ))
      .toList();
}

class NGOProfileScreen extends StatefulWidget {
  @override
  _NGOProfileScreenState createState() => _NGOProfileScreenState();
}

class _NGOProfileScreenState extends State<NGOProfileScreen> {
  Future ngoInfo;
  Future reportsInfo;
  Future completeInfo;
  int _current = 0;

  final CarouselController _seeMoreController = CarouselController();
  @override
  void initState() {
    ngoInfo = (context).read<FlutterFireAuthService>().getNGOInfo();
    reportsInfo = getreportsInfo();
    completeInfo = getCompleteInfo();

    super.initState();
  }

  Future getreportsInfo() async {
    return await (context)
        .read<FlutterFireAuthService>()
        .ngoGetReports('ongoing');
  }

  Future getCompleteInfo() async {
    return await (context)
        .read<FlutterFireAuthService>()
        .ngoGetReports('completed');
  }

  void refreshScreen() {
    setState(() {
      reportsInfo = getreportsInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            context.read<FlutterFireAuthService>().signOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AuthenMenu()),
                (Route<dynamic> route) => false);
            // if()
          },
        ),
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        centerTitle: true,
        title: Text('NGO Profile',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
      bottomNavigationBar: ButtomButton(
        refreshScreen: refreshScreen,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 25),
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: ngoInfo,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final result = snapshot.data;
                      // print(snapshot);
                      return Row(children: [
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
                                result.orgName,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Completed Tasks: ${result.completeTask}',
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 16)),
                              Text('Ongoing Tasks: ${result.remainingTask}',
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 16)),
                            ],
                          ),
                        )
                      ]);
                    },
                  ),
                ),

                SizedBox(
                  height: 35,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'On-Going',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: FutureBuilder(
                      future: reportsInfo,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final result = snapshot.data;
                        Function refresh = () {
                          setState(() {
                            ngoInfo = (context)
                                .read<FlutterFireAuthService>()
                                .getNGOInfo();
                            reportsInfo = getreportsInfo();
                            completeInfo = getCompleteInfo();
                          });
                        };
                        print(snapshot.data);
                        final imglist =
                            buildImageSliders(result, context, refresh);

                        if (result.isEmpty) {
                          return NoReportFound();
                        } else {
                          return Column(
                            children: [
                              CarouselSlider(
                                carouselController: _seeMoreController,
                                options: CarouselOptions(
                                    autoPlay: false,
                                    height: MediaQuery.of(context).size.height *
                                        0.55,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                items: imglist,
                              ),

                              // SizedBox(
                              //   height: 10,
                              // ),
                              // CarouselSlider(
                              //   carouselController: _seeMoreController,
                              //   options: CarouselOptions(
                              //     autoPlay: true,
                              //     height:
                              //         MediaQuery.of(context).size.height * 0.4,
                              //     enlargeCenterPage: true,
                              //   ),
                              //   items: seeMorelist,
                              // ),
                            ],
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Complete Tasks',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: FutureBuilder(
                      future: completeInfo,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final result = snapshot.data;
                        final Function refresh = () {
                          setState(() {
                            completeInfo = getCompleteInfo();
                          });
                        };
                        print(snapshot.data);
                        final imglist =
                            buildImageSliders(result, context, refresh);
                        final seeMorelist =
                            buildSeeMoreSliders(result, context);
                        if (result.isEmpty) {
                          return NoCompleteFound();
                        } else {
                          return Column(
                            children: [
                              CarouselSlider(
                                carouselController: _seeMoreController,
                                options: CarouselOptions(
                                    autoPlay: false,
                                    height: MediaQuery.of(context).size.height *
                                        0.55,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                items: imglist,
                              ),

                              // SizedBox(
                              //   height: 10,
                              // ),
                              // CarouselSlider(
                              //   carouselController: _seeMoreController,
                              //   options: CarouselOptions(
                              //     autoPlay: true,
                              //     height:
                              //         MediaQuery.of(context).size.height * 0.4,
                              //     enlargeCenterPage: true,
                              //   ),
                              //   items: seeMorelist,
                              // ),
                            ],
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                // RequestHistoryList(),
                // RequestHistoryList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoCompleteFound extends StatelessWidget {
  const NoCompleteFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Icon(
              Icons.description_rounded,
              color: Colors.grey[400],
              size: MediaQuery.of(context).size.height * 0.2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text('No Complete Task',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.080,
            ),
          ],
        ),
      ),
    );
  }
}

class NoReportFound extends StatelessWidget {
  const NoReportFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Icon(
              Icons.description_rounded,
              color: Colors.grey[400],
              size: MediaQuery.of(context).size.height * 0.2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text('No Report Found',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.080,
            ),
            Text('Press View Report below',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontSize: 19,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Icon(
              Icons.arrow_downward,
              color: Colors.grey[600],
              size: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtomButton extends StatelessWidget {
  const ButtomButton({
    this.refreshScreen,
    Key key,
  }) : super(key: key);
  final Function refreshScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.15,
        child: ElevatedButton.icon(
          icon: Icon(Icons.search),
          label: Text('View Report'),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            onPrimary: Colors.white,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ViewReport(refreshScreen: refreshScreen)),
            );
          },
        ));
  }
}
