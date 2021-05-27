import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/screens/GeneralUserScreen/SelectLocationScreen.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

final api = "AIzaSyDEupLpQBvxO2k82zixOTNfNtjcAAoNPDo";

class UploadReportScreen extends StatefulWidget {
  @override
  _UploadReportScreenState createState() => _UploadReportScreenState();
}

class _UploadReportScreenState extends State<UploadReportScreen> {
  final TextEditingController inputDescription = TextEditingController();

  String inputLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        centerTitle: true,
        title: Text('Upload Image',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
      bottomNavigationBar: ButtomButton(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 400,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
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
                      onPressed: () {},
                      icon: Icon(Icons.image),
                      label: Text('Upload Image')),
                ),
                Container(
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
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SelectLocationScreen()),
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: api, // Put YOUR OWN KEY here.
                                onPlacePicked: (result) {
                                  setState(() {
                                    inputLocation = result.formattedAddress;
                                  });
                                  print(result.adrAddress);
                                  print(result.formattedAddress);
                                  print(result.name);
                                  print(result.photos);
                                  Navigator.of(context).pop();
                                },
                                // initialPosition: HomePage.kInitialPosition,
                                useCurrentLocation: true,
                                initialPosition: LatLng(13.7563, 100.5018),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.location_on),
                        label: inputLocation == null
                            ? Text("Select Location")
                            : Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(inputLocation.length >= 91
                                              ? inputLocation.substring(0, 90) +
                                                  "..."
                                              : inputLocation)),
                                      Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Colors.white,
                                        size: 20.0,
                                      )
                                    ]),
                              ))),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines: null,
                    controller: inputDescription,
                    decoration:
                        kTextField.copyWith(hintText: 'Enter Description ...'),
                  ),
                ),
                // RequestHistoryList(),
                // RequestHistoryList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtomButton extends StatelessWidget {
  const ButtomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.15,
        child: ElevatedButton.icon(
          icon: Icon(Icons.send),
          label: Text('SUBMIT THE REPORT'),
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
