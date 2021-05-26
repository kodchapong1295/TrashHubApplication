import 'package:flutter/material.dart';
import 'Trip.dart';

class CustomeDialog extends StatelessWidget {
  final String title, description, button;
  final List<Trip> tripsList = [
    Trip("Cheigmai", "This is Cheigmai", DateTime.now()),
    Trip("Tonlor", "This is Tonlor", DateTime.now()),
    Trip("Bangcare", "This is Cheigmai", DateTime.now()),
    Trip("Ratchapreuk", "This is Cheigmai", DateTime.now()),
    Trip("Ratchapreuk", "This is Cheigmai", DateTime.now()),
    Trip("Ratchapreuk", "This is Cheigmai", DateTime.now()),
  ];

  CustomeDialog({this.title, this.description, this.button});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(
    BuildContext context,
  ) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Accept"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
