import 'package:flutter/material.dart';
import 'userViewApp/userTab.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'ngoViewApp/ngoTab.dart';
import 'userViewApp/editProfile.dart';
import 'backendRequests.dart';
import 'signIn.dart';

class CustomPopupMenu {
  CustomPopupMenu({this.title});
  String title;
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: "Edit Profile"),
  CustomPopupMenu(title: "Log Out"),
  CustomPopupMenu(title: "Delete Account"),
];

class AppPage extends StatefulWidget {
  AppPage({Key key, @required this.user, @required this.userType}) : super(key: key);

  final User user;
  final int userType;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  CustomPopupMenu _selectedChoices = choices[0];
  var scaffoldContext;

  void _select(CustomPopupMenu choice) {
    setState(() {
      _selectedChoices = choice;
    });
    if (choice.title == "Edit Profile") {
      Navigator.push (context, MaterialPageRoute(
          builder: (context) => MyEditPage(user: widget.user, userType: widget.userType)
      )
      );
    }
    else if (choice.title == "Log Out") {
      Navigator.push (context, MaterialPageRoute(
          builder: (context) => MySignInPage()
      )
      );
    }
    else if (choice.title == "Delete Account") {
      deleteUserRequests(context: scaffoldContext, user: widget.user);
    }
  }

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        home: Scaffold(
                  appBar: AppBar(
                    backgroundColor: appBlue,
                    title: Center (
                      child: widget.userType == 0 ? Text(widget.user.uname) : Text("NGO"),
                    ),
                    centerTitle: true,
                    actions: <Widget>[
                      PopupMenuButton<CustomPopupMenu>(
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.settings),
                        ),
                        elevation: 3.2,
                        onCanceled: () {
                          print('You have not chosen anything');
                        },
                        tooltip: 'Settings',
                        onSelected: _select,
                        offset: Offset(0, 102),
                        itemBuilder: (BuildContext context) {
                          return choices.map((CustomPopupMenu choice) {
                            return PopupMenuItem<CustomPopupMenu>(
                              value: choice,
                              child: Text(choice.title, style: TextStyle(color: Colors.grey)),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  body:  Builder (
                      builder: (BuildContext context) {
                        scaffoldContext = context;
                       return
                          widget.userType == 0
                          ? UserTab(user: widget.user)
                          : NGOTab(user: widget.user);
                       }
                  ),
        ),
    );
  }
}