import 'package:flutter/material.dart';
import 'package:trashhub/components/ViewReport/homeview.dart';

class ViewReport extends StatefulWidget {
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: (Text('View Report')),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(child: HomeView()),
    );
  }
}
