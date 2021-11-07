import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'ngoApplicantProfile.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class NGOFetchApp extends StatefulWidget {
  NGOFetchApp({Key key, @required this.job, @required this.app}) : super(key: key);

  final Job job;
  final Application app;

  @override
  _NGOFetchAppState createState() => _NGOFetchAppState();
}

class _NGOFetchAppState extends State<NGOFetchApp> {

  User user;

  @override
  Widget build(BuildContext context) {

    getUserRequest({String userid}) async {
      Response response;
      Dio dio = new Dio();
      String url = endpoint + "/users/get?id=" + userid;
      try {
        response = await dio.get(url);
        final userJson = jsonDecode(response.data.toString())["data"];

        setState(() {
          user = User.fromJson(userJson);
        });
      }
      catch (error) {
      }
    }

    getUserRequest(userid: widget.app.userid);

    return
      user == null ? Text("")
          : new InkWell(
        onTap: () {
          if (user != null) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => ApplicantProfile(app: widget.app, job: widget.job, user: user)
            )
            );
          }
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(color: Colors.white, spreadRadius: 3.0)]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(10)),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: appGold, offset: Offset(0,0))]
                  ),
                  child:
                        Center(
                            child: Icon(
                                Icons.person_pin, color: Colors.white, size: 50.0)
                        ),
                ),
                const SizedBox(width: 20),
                Column (
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Center (
                      child: Text(user.uname, style: TextStyle(fontSize: 20, color: appBlue))
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              ],
            )
        ),
      );
  }
}