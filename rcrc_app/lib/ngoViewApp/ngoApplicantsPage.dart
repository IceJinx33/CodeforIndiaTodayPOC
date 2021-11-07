import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'ngoApplicantContainer.dart';
import 'package:rcrc_app/errorAlerts.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'dart:convert';

class NGOMainFetchApps extends StatefulWidget {
  NGOMainFetchApps({Key key, @required this.job}) : super(key: key);

  final Job job;

  @override
  _NGOMainFetchAppsState createState() => _NGOMainFetchAppsState();
}

class _NGOMainFetchAppsState extends State<NGOMainFetchApps> {

  List<Application> list = List();
  List<Job> users = List();
  var isLoading = false;

  final GlobalKey<RefreshIndicatorState> _ngoRefreshIndicatorAppKey =
  new GlobalKey<RefreshIndicatorState>();

  Future<void> getApps() async {

    setState(() {
      isLoading = true;
    });

    Response response;
    Dio dio = new Dio();
    String url = endpoint + "/applications/list?job=" + widget.job.jid;

    try {
      response = await dio.get(url);
      final apps = jsonDecode(response.data.toString())["data"];

      setState(() {
        isLoading = false;
        list = (apps as List)
            .map((data) => new Application.fromJson(data))
            .toList();
      });

    }
    catch (error){
      showAlertDialog(context);
    }

  }

  @override
  void initState() {
    super.initState();
    getApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text("Applicants"),
          backgroundColor: appBlue,
        ),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
            key: _ngoRefreshIndicatorAppKey,
            child: Container (
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Scaffold(
                body: isLoading || list.length == 0
                    ? Center(
                  child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(appGold)),
                )
                    : ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NGOFetchApp(job: widget.job, app: list[index]);
                    }),
              ),
            ),
            onRefresh: getApps
        )
    );
  }
}