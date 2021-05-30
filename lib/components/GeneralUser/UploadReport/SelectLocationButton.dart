import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class SelectLocationButton extends StatelessWidget {
  const SelectLocationButton({
    Key key,
    @required this.inputLocation,
    @required this.onPressed,
  }) : super(key: key);

  final String inputLocation;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        width: MediaQuery.of(context).size.width * 0.8,
        height: inputLocation == null ? 40 : 75,
        child: TextButton.icon(
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: kPrimaryColor,
                textStyle: TextStyle(
                  fontSize: 15,
                )),
            onPressed: onPressed,
            icon: Icon(Icons.location_on),
            label: inputLocation == null
                ? Text("Select Location")
                : Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(inputLocation.length >= 91
                                  ? inputLocation.substring(0, 90) + "..."
                                  : inputLocation)),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ]),
                  )));
  }
}
