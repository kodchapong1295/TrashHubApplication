import 'package:flutter/material.dart';

Color kPrimaryColor = Color(0xff2ba58a);

InputDecoration kTextField = InputDecoration(
  hintText: "Enter Email",
  // fillColor: kPrimaryColor,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    // borderSide: BorderSide(
    //   color: kPrimaryColor,
    //   width: 2.0,
    // ),
  ),
);
