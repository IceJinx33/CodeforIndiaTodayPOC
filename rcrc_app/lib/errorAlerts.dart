import 'package:flutter/material.dart';
import 'constants.dart';

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error", style: TextStyle(fontSize: 20.0, color: appBlue)),
    content: Text("Your request could not be processed. Please try again.",
        style: TextStyle(color: Colors.grey)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}