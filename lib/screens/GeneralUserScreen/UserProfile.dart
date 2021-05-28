import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashhub/components/DialogShowStatus.dart';
import 'package:trashhub/components/ViewReport/CustomDialog.dart';
import 'package:trashhub/constants.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trashhub/models/GeneralUser.dart';

import 'package:provider/provider.dart';
import 'package:trashhub/Firebase.dart';

import 'package:trashhub/screens/AuthenMenu.dart';

import 'UploadReportScreen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      item,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 255, 25, 0),

                              // Color.fromARGB(200, 50, 205, 50),
                              // Color.fromARGB(200, 255, 165, 0),
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
                            Icon(
                              Icons.hourglass_empty,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            Icon(
                              Icons.flag_outlined,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            Text(
                              'No. ${imgList.indexOf(item)} image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Future userInfo;
  @override
  void initState() {
    userInfo = (context).read<FlutterFireAuthService>().getGeneralUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void popUntilRoot({Object result}) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
        popUntilRoot();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await context.read<FlutterFireAuthService>().signOut();
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
              // popUntilRoot();
            }
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => AuthenMenu()));
          },
        ),
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        centerTitle: true,
        title: Text('Home',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
      bottomNavigationBar: ButtomButton(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future: userInfo,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final result = snapshot.data;
                      print(result.totalReport);
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
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18))
                            ],
                          ),
                        )
                      ]);
                    }),
              ),

              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'My Requests',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.55,
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.02,
              //         ),
              //         Icon(
              //           Icons.description_rounded,
              //           color: Colors.grey[400],
              //           size: MediaQuery.of(context).size.height * 0.2,
              //         ),
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.01,
              //         ),
              //         Text('No Request Found',
              //             style: TextStyle(
              //               color: Colors.grey[700],
              //               fontWeight: FontWeight.bold,
              //               fontSize: 34,
              //             )),
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.08,
              //         ),
              //         Text('Add New Request below',
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.grey[600],
              //               fontSize: 19,
              //             )),
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.01,
              //         ),
              //         Icon(
              //           Icons.arrow_downward,
              //           color: Colors.grey[600],
              //           size: 100.0,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height * 0.45,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.41,
                height: 45,
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: kPrimaryColor,
                        textStyle: TextStyle(
                          fontSize: 18,
                        )),
                    onPressed: () async {
                      await (context)
                          .read<FlutterFireAuthService>()
                          .getUserReports();
                      showDialog(
                          context: context,
                          builder: (context) => DialogShowStatus(
                                topic: "Request Details",
                                no: "1",
                                date: "05/05/2021",
                                status: "On-going",
                                location: "BangCare",
                                description: "trip.description",
                              ));
                    },
                    icon: Icon(Icons.info_outline),
                    label: Text('See More')),
              ),
              // RequestHistoryList(),
              // RequestHistoryList()
            ],
          ),
        ),
      ),
    );
  }
}

// class ProfileInfo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class ButtomButton extends StatelessWidget {
  const ButtomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.15,
        child: ElevatedButton.icon(
          icon: Icon(Icons.camera_alt_rounded),
          label: Text('NEW REQUEST'),
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
              MaterialPageRoute(builder: (context) => UploadReportScreen()),
            );
          },
        ));
  }
}
