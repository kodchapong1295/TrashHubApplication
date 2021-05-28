import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trashhub/Firebase.dart';
import 'package:trashhub/components/RoundedButton.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/screens/GeneralUserScreen/SelectLocationScreen.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:provider/provider.dart';

final api = "AIzaSyDEupLpQBvxO2k82zixOTNfNtjcAAoNPDo";

class UploadReportScreen extends StatefulWidget {
  @override
  _UploadReportScreenState createState() => _UploadReportScreenState();
}

class _UploadReportScreenState extends State<UploadReportScreen>
    with TickerProviderStateMixin {
  OverlayEntry overlayEntry;
  GlobalKey appBarKey = GlobalKey();
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation =
        Tween<double>(begin: 1.0, end: 1.0).animate(animationController);
  }

  final TextEditingController inputDescription = TextEditingController();
  String inputLocation;
  File _image;
  final picker = ImagePicker();
  String imgUrl;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    showOverLay(status) async {
      OverlayState overlayState = Overlay.of(context);
      RenderBox renderBox = appBarKey.currentContext.findRenderObject();
      Offset offset = renderBox.localToGlobal(Offset.zero);

      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: offset.dy + renderBox.size.height,
          right: 0.0,
          left: 0.0,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Material(
              child: Opacity(
                opacity: animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      animationController.addListener(() {
        overlayState.setState(() {});
      });

      overlayState.insert(overlayEntry);
      animationController.forward();
      await Future.delayed(Duration(seconds: 2)).whenComplete(() {
        overlayEntry.remove();
        animationController.reverse();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        key: appBarKey,
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Upload Image',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
      bottomNavigationBar: ButtomButton(
        onPress: () async {
          final url = await (context)
              .read<FlutterFireAuthService>()
              .uploadImageToFirebase(_image);
          this.imgUrl = url;
          final status = await (context)
              .read<FlutterFireAuthService>()
              .createRequest(
                  imgUrl, inputLocation, inputDescription.text, context);
          Navigator.of(context).pop();
          showOverLay(status);
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _image == null
                          ? Image.asset(
                              'images/placeholderImg.png',
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              alignment: Alignment.center,
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                    ),
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
                      onPressed: getImage,
                      icon: Icon(Icons.image),
                      label: _image == null
                          ? Text("Upload Image")
                          : Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      _image.path
                                                  .split('/')
                                                  .last
                                                  .replaceAll(
                                                      'image_picker', "")
                                                  .length >=
                                              28
                                          ? _image.path
                                                  .split('/')
                                                  .last
                                                  .replaceAll(
                                                      'image_picker', "")
                                                  .substring(0, 28) +
                                              "..."
                                          : _image.path
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
                                      ),
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

  showOverLay() async {
    OverlayState overlayState = Overlay.of(context);
    RenderBox renderBox = appBarKey.currentContext.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + renderBox.size.height,
        right: 0.0,
        left: 0.0,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Material(
            child: Opacity(
              opacity: animation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Submit Completee",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    animationController.addListener(() {
      overlayState.setState(() {});
    });

    overlayState.insert(overlayEntry);
    animationController.forward();
    await Future.delayed(Duration(seconds: 2)).whenComplete(() {
      overlayEntry.remove();
      animationController.reverse();
    });
  }
}

class ButtomButton extends StatelessWidget {
  const ButtomButton({
    this.onPress,
    Key key,
  }) : super(key: key);

  final Function onPress;
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
          onPressed: onPress,
        ));
  }
}
