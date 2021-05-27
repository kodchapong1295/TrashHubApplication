import 'package:flutter/material.dart';
import 'package:trashhub/components/ViewReport/homeview.dart';
import 'dart:async';

class ViewReport extends StatefulWidget {
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
        title: (Text('View Report')),
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: HomeView(),
        onRefresh: refreshList,
      ),
    );
  }
}
