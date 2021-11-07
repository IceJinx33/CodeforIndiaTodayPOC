import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'applicationDisplay.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class FetchApp extends StatefulWidget {
  FetchApp({Key key, @required this.user, @required this.app}) : super(key: key);

  final User user;
  final Application app;

  @override
  _FetchAppState createState() => _FetchAppState();
}

class _FetchAppState extends State<FetchApp> {

  Job job;

  @override
  Widget build(BuildContext context) {

    getJobRequest({String jobid}) async {
      Response response;
      Dio dio = new Dio();
      String url = endpoint + "/jobs/get?id=" + jobid;
      try {
        response = await dio.get(url);
        final jobJson = jsonDecode(response.data.toString())["data"];

        setState(() {
          job = Job.fromJson(jobJson);
        });
      }
      catch (error) {
      }
    }

    getJobRequest(jobid: widget.app.jobid);

    return
      job == null ? Text("")
      : new InkWell(
        onTap: () {
          if (job != null) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => ApplicationPage(app: widget.app, job: job, user: widget.user)
            )
            );
          }
        },
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(color: Colors.white, spreadRadius: 3.0)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      boxShadow: [BoxShadow(color: accBlue)]
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Icon(
                                Icons.assignment_ind, color: Colors.white, size: 50.0)
                        ),
                      ]
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(job.jname, style: TextStyle(fontSize: 20.0,
                            color: appBlue,
                            fontWeight: FontWeight.bold)),
                        Text(widget.app.astatus, style: TextStyle(fontSize: 20.0,
                            color: appGold,
                            fontWeight: FontWeight.bold))
                      ]
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Job ID : " + widget.app.jobid, style: TextStyle(
                              fontSize: 15.0, color: Colors.grey))
                        ]
                    )
                )
              ],
            )
        ),
      );
  }
}