import 'package:flutter/material.dart';
import 'package:trashhub/constants.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key key,
    @required this.inputDescription,
  }) : super(key: key);

  final TextEditingController inputDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        minLines: null,
        maxLines: null,
        controller: inputDescription,
        decoration: kTextField.copyWith(hintText: 'Enter Description ...'),
      ),
    );
  }
}
