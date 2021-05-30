import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trashhub/Firebase.dart';
import 'package:trashhub/components/GeneralUser/ButtomButton.dart';
import 'package:trashhub/components/GeneralUser/UploadReport/DescriptionTextField.dart';
import 'package:trashhub/components/GeneralUser/UploadReport/SelectLocationButton.dart';
import 'package:trashhub/components/GeneralUser/UploadReport/ShowUploadedImageCard.dart';
import 'package:trashhub/components/GeneralUser/UploadReport/UploadImageButton.dart';
import 'package:trashhub/constants.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// ignore: implementation_imports
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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

  void onSubmit() async {
    final url = await (context)
        .read<FlutterFireAuthService>()
        .uploadImageToFirebase(_image);
    this.imgUrl = url;
    final status = await (context)
        .read<FlutterFireAuthService>()
        .createRequest(imgUrl, inputLocation, inputDescription.text, context);
    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserProfileScreen()));
    showOverLay(status);
  }

  void onSelectLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: api, // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            setState(() {
              inputLocation = result.formattedAddress;
            });
            Navigator.of(context).pop();
          },
          // initialPosition: HomePage.kInitialPosition,
          useCurrentLocation: true,
          initialPosition: LatLng(13.7563, 100.5018),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          icon: Icon(Icons.send),
          label: 'SUBMIT THE REPORT',
          onPressed:
              (_image == null || inputLocation == null) ? null : onSubmit),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ShowUploadedImageCard(image: _image, onTap: getImage),
                UploadImageButton(
                  image: _image,
                  onPressed: getImage,
                ),
                SelectLocationButton(
                  inputLocation: inputLocation,
                  onPressed: onSelectLocation,
                ),
                DescriptionTextField(inputDescription: inputDescription),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
