import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'package:rcrc_app/backendRequests.dart';

class ApplicantProfile extends StatefulWidget {
  ApplicantProfile({Key key, @required this.app, @required this.job, @required this.user}) : super(key: key);

  final Application app;
  final Job job;
  final User user;

  @override
  _ApplicantProfileState createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {

  var scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Application Profile"),
        centerTitle: true,
        backgroundColor: appBlue,
        elevation: 0,
      ),

      body: Builder (
        builder: (BuildContext context) {

          scaffoldContext = context;
          return SingleChildScrollView(
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

                      // Action Buttons
                      Container (
                          padding: EdgeInsets.only(left: 50, right: 50, top: 70, bottom: 50),
                          child: Row (
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: <Widget> [
                                     _acceptButton(context),
                                     const SizedBox(width: 50),
                                     _rejectButton(context),
                                  ],
                          ),
                      ),
                  ],
              ),
          );
        },
      ),
    );
  }

  Widget _acceptButton(context) {
    return
      Center (
        child: RaisedButton(
          onPressed: () {
            updateUserApp(context: scaffoldContext, user: widget.user, job: widget.job, status: "Accepted");
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
                color: appGold
            ),
            padding: const EdgeInsets.all(15.0),
            child:
            const Text('Accept', style: TextStyle(fontSize: 20)),
          ),
        ),
      );
  }

  Widget _rejectButton(context) {
    return
      Center (
        child: RaisedButton(
          onPressed: () {
            updateUserApp(context: scaffoldContext, user: widget.user, job: widget.job, status: "Rejected");
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
                color: appGold
            ),
            padding: const EdgeInsets.all(15.0),
            child:
            const Text('Reject', style: TextStyle(fontSize: 20)),
          ),
        ),
      );
  }

}