import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';
import 'package:trashhub/screens/GeneralUserScreen/UploadReportScreen.dart';

class SelectLocationScreen extends StatelessWidget {
  final TextEditingController inputDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        centerTitle: true,
        title: Text('Select Location',
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
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines: null,
                    controller: inputDescription,
                    decoration:
                        kTextField.copyWith(hintText: 'Enter Address ...'),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.60,
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
          icon: Icon(Icons.location_on),
          label: Text('CONFIRM LOCATION'),
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
