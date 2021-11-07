import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'applicationContainer.dart';
import 'package:rcrc_app/errorAlerts.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'dart:convert';

class MainFetchApps extends StatefulWidget {
  MainFetchApps({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _MainFetchAppsState createState() => _MainFetchAppsState();
}

class _MainFetchAppsState extends State<MainFetchApps> {

  List<Application> list = List();
  List<Job> jobs = List();
  var isLoading = false;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorAppKey =
  new GlobalKey<RefreshIndicatorState>();

  Future<void> getApps() async {

    setState(() {
      isLoading = true;
    });

    Response response;
    Dio dio = new Dio();
    String url = endpoint + "/applications/list?user=" + widget.user.uid;

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

    return RefreshIndicator(
        key: _refreshIndicatorAppKey,
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
                  color: Colors.white,
                ),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return FetchApp(user: widget.user, app: list[index]);
                }),
          ),
        ),
        onRefresh: getApps
    );
  }
}