import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'jobContainer.dart';
import 'package:rcrc_app/errorAlerts.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'dart:convert';

class MainFetchJobs extends StatefulWidget {
  MainFetchJobs({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _MainFetchJobsState createState() => _MainFetchJobsState();
}

class _MainFetchJobsState extends State<MainFetchJobs> {

  List<Job> list = List();
  var isLoading = false;

  final GlobalKey<RefreshIndicatorState> _refreshJobIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  Future<void> getJobs() async {

    setState(() {
      isLoading = true;
    });

    Response response;
    Dio dio = new Dio();
    String url = endpoint + "/jobs/list/user";

    try {
      response = await dio.get(url);
      final jobs = jsonDecode(response.data.toString())["data"];

      setState(() {
        isLoading = false;
        list = (jobs as List)
            .map((data) => new Job.fromJson(data))
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
    getJobs();
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        key: _refreshJobIndicatorKey,
        color: appGold,
        backgroundColor: Colors.white,
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
                  return buildJobContainer(context, list[index], widget.user, 0);
                }),
          ),
        ),
        onRefresh: getJobs
    );
  }
}