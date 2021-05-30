import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({
    Key key,
    @required this.image,
    @required this.onPressed,
  }) : super(key: key);

  final File image;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 40,
      child: TextButton.icon(
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: kPrimaryColor,
              textStyle: TextStyle(
                fontSize: 15,
              )),
          onPressed: onPressed,
          icon: Icon(Icons.image),
          label: image == null
              ? Text("Upload Image")
              : Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                          image.path
                                      .split('/')
                                      .last
                                      .replaceAll('image_picker', "")
                                      .length >=
                                  28
                              ? image.path
                                      .split('/')
                                      .last
                                      .replaceAll('image_picker', "")
                                      .substring(0, 28) +
                                  "..."
                              : image.path
                                  .split('/')
                                  .last
                                  .replaceAll('image_picker', ""),
                          textAlign: TextAlign.center,
                        )),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 20.0,
                        )
                      ]),
                )),
    );
  }
}
