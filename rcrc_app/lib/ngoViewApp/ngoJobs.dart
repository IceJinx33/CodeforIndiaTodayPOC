import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'package:rcrc_app/errorAlerts.dart';
import 'package:rcrc_app/ngoViewApp/jobCreateForm.dart';
import 'package:rcrc_app/userViewApp/jobContainer.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class NGOJobs extends StatefulWidget {
  NGOJobs({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _NGOJobsState createState() => _NGOJobsState();
}

class _NGOJobsState extends State<NGOJobs> {
  List<Job> list = List();
  var isLoading = false;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
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
     return Container (
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Scaffold(
        appBar: AppBar(
            title: Center (
              child: Text("    Jobs")
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: appGold,
            actions: <Widget>[
                IconButton(icon: Icon(Icons.add_circle, color: Colors.white),
                    tooltip: "Add a Job",
                    onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => JobCreatePage(user: widget.user)
                             )
                          );
                    })
              ]
        ),
        body: RefreshIndicator(
            color: appGold,
            backgroundColor: Colors.white,
            key: _refreshIndicatorKey,
            child: Container (
              color: Colors.white,
              padding: EdgeInsets.only(top: 20),
              child: isLoading || list.length == 0
                  ? Center(
                child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(appGold)),
              )
                  : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white,
                  ),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildJobContainer(context, list[index], widget.user, 1);
                  }),
            ),
            onRefresh: getJobs)
      ),
    );
  }
}
