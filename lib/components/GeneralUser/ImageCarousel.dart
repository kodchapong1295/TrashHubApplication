import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/components/DialogShowStatus.dart';
import 'package:trashhub/models/Report.dart';

List<Widget> buildImageSliders(List<Report> reports, BuildContext context) {
  return reports
      .map((r) => Container(
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) => DialogShowStatus(
                          topic: "Request Details",
                          id: r.id,
                          date: r.date,
                          status: r.status,
                          location: r.location,
                          description: r.description,
                          responsible_by: r.responsible_by,
                        ));
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
            Text('No Request Found',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.080,
            ),
            Text('Add New Request below',
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

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    Key key,
    @required this.reportsInfo,
    @required this.carouselOptions,
    @required int current,
  })  : _current = current,
        super(key: key);

  final Future reportsInfo;
  final CarouselOptions carouselOptions;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: reportsInfo,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final result = snapshot.data;

          final imglist = buildImageSliders(result, context);

          if (result.isEmpty) {
            return NoReportFound();
          } else {
            return Column(
              children: [
                CarouselSlider(
                  options: carouselOptions,
                  items: imglist,
                ),
                SizedBox(
                  height: 5,
                ),
                _current != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imglist.map((url) {
                          int index = imglist.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(43, 165, 138, 0.9)
                                  : Color.fromRGBO(43, 165, 138, 0.4),
                            ),
                          );
                        }).toList(),
                      )
                    : Container(),
              ],
            );
          }
        });
  }
}
