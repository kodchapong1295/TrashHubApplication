import 'package:flutter/material.dart';
import 'package:trashhub/components/ViewReport/homeview.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/screens/AuthenMenu.dart';
import 'package:trashhub/screens/NGOsScreen/NGOProfile.dart';

class ViewReport extends StatefulWidget {
  Function refreshScreen;
  ViewReport({this.refreshScreen});
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();

    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      // เอาไว้ใส่ว่ารีเฟสแล้วงจะทำอะไร
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kPrimaryColor,
          onPressed: () async {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthenMenu()),
            );
          },
        ),
        title: (Text(
          'View Report',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        )),
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: HomeView(
          refreshScreen: widget.refreshScreen,
        ),
        onRefresh: refreshList,
      ),
    );
  }
}
