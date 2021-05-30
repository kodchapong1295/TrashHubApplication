import 'package:flutter/material.dart';
import 'package:trashhub/components/GeneralUser/ImageCarousel.dart';
import 'package:trashhub/components/GeneralUser/MyRequestCard.dart';
import 'package:trashhub/components/GeneralUser/UserInfoCard.dart';
import 'package:trashhub/components/GeneralUser/ButtomButton.dart';
import 'package:trashhub/constants.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:trashhub/Firebase.dart';
import 'package:trashhub/screens/AuthenMenu.dart';
import 'package:trashhub/screens/GeneralUserScreen/UploadReportScreen.dart';

// import 'UploadReportScreen.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Future reportsInfo;
  Future userInfo;
  int _current = 0;

  CarouselOptions carouselOptions;
  @override
  void initState() {
    userInfo = (context).read<FlutterFireAuthService>().getGeneralUserInfo();
    reportsInfo = getreportsInfo();

    super.initState();
  }

  Future getreportsInfo() async {
    print('get repoert is call');
    return await (context).read<FlutterFireAuthService>().getUserReports();
  }

  @override
  Widget build(BuildContext context) {
    carouselOptions = CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.55,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await context.read<FlutterFireAuthService>().signOut();
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
        title: Text('Home',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
      bottomNavigationBar: ButtomButton(
          icon: Icon(Icons.camera_alt_rounded),
          label: "NEW REQUEST",
          screen: UploadReportScreen()),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              UserInfoCard(userInfo: userInfo),
              MyRequestsCard(),
              ImageCarousel(
                  reportsInfo: reportsInfo,
                  carouselOptions: carouselOptions,
                  current: _current)
            ],
          ),
        ),
      ),
    );
  }
}
