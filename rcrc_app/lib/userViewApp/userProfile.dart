import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';


class UserPage extends StatefulWidget {
  UserPage({Key key, @required this.user, @required this.userType}) : super(key: key);


  final User user;
  final int userType;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
     return Scaffold (
       backgroundColor: Colors.white,
       appBar: AppBar(
           backgroundColor: Colors.white,
           elevation: 0,
         ),

         body: SingleChildScrollView(
           child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

         // Contact Picture Placeholder
              Container (
                 padding: EdgeInsets.only(top: 50),
                 child: Center(
                   child: Icon(Icons.contact_phone, size: 200, color: appGold),
                 ),
               ),

              // User ID
              Container (
                padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Text( 'User ID',
                        style: TextStyle(fontSize: 20.0, color: Colors.grey)
                    ),
                    Container (
                      child: Text( widget.user.uid,
                          style: TextStyle(fontSize: 20.0, color: appBlue)
                      ),
                    ),
                  ],
                ),
              ),

              // Name
              Container (
                 padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                 child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text( 'Name',
                          style: TextStyle(fontSize: 20.0, color: Colors.grey)
                      ),
                      Container (
                         child: Text( widget.user.uname,
                          style: TextStyle(fontSize: 20.0, color: appBlue)
                      ),
                     ),
                    ],
                 ),
              ),

              // Phone Number
              Container (
                padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Text( 'Contact',
                      style: TextStyle(fontSize: 20.0, color: Colors.grey)
                    ),
                    Container (
                      child: Text( widget.user.ucontact,
                      style: TextStyle(fontSize: 20.0, color: appBlue)
                      ),
                    ),
                  ],
                ),
              ),
             ],
           ),
         ),
     );
  }

}