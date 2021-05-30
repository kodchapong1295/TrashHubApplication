import 'dart:io';

import 'package:flutter/material.dart';

class ShowUploadedImageCard extends StatelessWidget {
  const ShowUploadedImageCard({
    Key key,
    @required this.image,
    @required this.onTap,
  }) : super(key: key);

  final File image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: image == null
              ? Image.asset(
                  'images/placeholderImg.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                )
              : Image.file(
                  image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }
}
