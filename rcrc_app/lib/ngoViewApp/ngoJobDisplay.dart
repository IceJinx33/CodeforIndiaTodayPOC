import 'package:flutter/material.dart';
import 'package:rcrc_app/backendRequests.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'package:rcrc_app/ngoViewApp/ngoApplicantsPage.dart';
import 'updateJob.dart';

class CustomPopupMenu {
  CustomPopupMenu({this.title});
  String title;
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: "See Applicants"),
  CustomPopupMenu(title: "Update Job Details"),
  CustomPopupMenu(title: "Delete Job"),
];

// This is the context on which error messages are displayed
var scaffContext;

class NGOJobPage extends StatefulWidget {
  NGOJobPage({Key key, @required this.job, @required this.user}) : super(key: key);

  final Job job;
  final User user;

  @override
  _NGOJobPageState createState() => _NGOJobPageState();
}

class _NGOJobPageState extends State<NGOJobPage> {

  CustomPopupMenu _selectedChoices = choices[0];

  @override
  Widget build(BuildContext context) {

    void _select(CustomPopupMenu choice) {

      setState(() {
        _selectedChoices = choice;
      });
      if (choice.title == "See Applicants") {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NGOMainFetchApps(job: widget.job)
        )
        );
      }
      else if (choice.title == "Update Job Details") {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => JobUpdatePage(user: widget.user, job: widget.job)
        )
        );
      }
      else if (choice.title == "Delete Job") {
        deleteJobRequests(context: scaffContext, user: widget.user, job: widget.job, userType: 1);
      }
    }

    return Scaffold (
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Job Details"),
        backgroundColor: appBlue,
        actions: <Widget>[
          PopupMenuButton<CustomPopupMenu>(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child:
              Icon(Icons.more_vert),
            ),
            elevation: 3.2,
            onCanceled: () {
              print('You have not chosen anything');
            },
            tooltip: 'Actions Menu',
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

      body: Builder (
        builder: (BuildContext context) {
          scaffContext = context;
          return SingleChildScrollView(
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                // Job Picture Placeholder
                Container (
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Icon(Icons.business_center, size: 200, color: appGold),
                  ),
                ),

                // Job ID
                Container (
                  padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Center(
                        child: Text( 'Job ID',
                            style: TextStyle(fontSize: 20.0, color: Colors.grey)
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container (
                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 35, right: 35),
                          child: Center (
                            child: Text( widget.job.jid,
                                style: TextStyle(fontSize: 20.0, color: appBlue)
                            ),
                          )
                      ),
                    ],
                  ),
                ),

                // Job Name
                Container (
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text( 'Job Name',
                          style: TextStyle(fontSize: 20.0, color: Colors.grey)
                      ),
                      Container (
                        child: Text( widget.job.jname,
                            style: TextStyle(fontSize: 20.0, color: appBlue)
                        ),
                      ),
                    ],
                  ),
                ),

                // Job Status
                Container (
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text( 'Job Status',
                          style: TextStyle(fontSize: 20.0, color: Colors.grey)
                      ),
                      Container (
                        child: Text( widget.job.jstatus,
                            style: TextStyle(fontSize: 20.0, color: appBlue)
                        ),
                      ),
                    ],
                  ),
                ),

                // Job Description
                Container (
                  padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Center(
                        child: Text( 'Job Description',
                            style: TextStyle(fontSize: 20.0, color: Colors.grey)
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container (
                          padding: EdgeInsets.all(5.0),
                          child: Center (
                            child: Text( widget.job.jdescription,
                                style: TextStyle(fontSize: 20.0, color: appBlue)
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}