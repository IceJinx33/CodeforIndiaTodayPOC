import 'package:flutter/material.dart';
import 'package:rcrc_app/backendRequests.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';

class JobPage extends StatefulWidget {
  JobPage({Key key, @required this.job, @required this.user}) : super(key: key);

  final Job job;
  final User user;

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {

  @override
  Widget build(BuildContext context) {
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
      ),

      body: Builder (
        builder: (BuildContext context) {
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
            _applyButton(context),
            const SizedBox(height: 50),
            ],
          ),
        );
       },
      ),
    );
  }

  Widget _applyButton(context) {
    return
      Center (
        child: RaisedButton(
          onPressed: () {
            postUserApp(context: context, user: widget.user, job: widget.job);
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
                color: appGold
            ),
            padding: const EdgeInsets.all(15.0),
            child:
            const Text(' Apply ', style: TextStyle(fontSize: 20)),
          ),
        ),
      );
  }


}