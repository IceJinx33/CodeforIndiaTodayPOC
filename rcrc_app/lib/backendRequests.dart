import 'package:flutter/material.dart';
import 'dataModels.dart';
import 'appScreen.dart';
import 'package:dio/dio.dart';
import 'errorAlerts.dart';
import 'signIn.dart';
import 'constants.dart';

// Create user info request
postUserRequests({BuildContext context, User user, int userType}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/users/add";
  FormData userData = new FormData.fromMap({
    "id": user.uid,
    "name": user.uname,
    "contact": user.ucontact
  });

  const snackBar = SnackBar(
    content: Text('Creating your account ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AppPage(user: user, userType: userType)
    )
    );
  }
  catch (error){
    showAlertDialog(context);
  }
}

// Update user info request
updateUserRequests({BuildContext context, User user, int userType}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/users/update";
  FormData userData = new FormData.fromMap({
    "id": user.uid,
    "name": user.uname,
    "contact": user.ucontact
  });

  const snackBar = SnackBar(
    content: Text('Updating your profile ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AppPage(user: user, userType: userType)
    )
    );
  }
  catch (error){
    showAlertDialog(context);
  }
}

// Delete user request
deleteUserRequests({BuildContext context, User user}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/users/remove";
  FormData userData = new FormData.fromMap({
    "id": user.uid
  });

  const snackBar = SnackBar(
    content: Text('Deleting your account ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MySignInPage()
    )
    );
  }
  catch (error){
    showAlertDialog(context);
  }
}

// Submit user application for job
postUserApp({BuildContext context, User user, Job job}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/applications/add";
  FormData userData = new FormData.fromMap({
    "job": job.jid,
    "user": user.uid,
    "status": "Sent"
  });

  const snackBar = SnackBar(
    content: Text('Submitting your application ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;
  }
  catch (error){
    showAlertDialog(context);
  }
}

// Update user application for job
updateUserApp({BuildContext context, User user, Job job, String status}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/applications/update";
  FormData userData = new FormData.fromMap({
    "job": job.jid,
    "user": user.uid,
    "status": status
  });

  const snackBar = SnackBar(
    content: Text('Informing applicant ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;
  }
  catch (error){
    showAlertDialog(context);
  }
}

// Delete application request
deleteAppRequest({BuildContext context, Application app, User user, int userType}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/applications/remove";
  FormData userData = new FormData.fromMap({
    "job": app.jobid,
    "user": app.userid
  });

  const snackBar = SnackBar(
    content: Text('Withdrawing your application ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AppPage(user: user, userType: userType)
    )
    );

  }
  catch (error){
    showAlertDialog(context);
  }
}

// Create job info request
postJobRequests({BuildContext context, Job job, User user, int userType}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/jobs/add";
  FormData userData = new FormData.fromMap({
    "id": job.jid,
    "name": job.jname,
    "description": job.jdescription,
    "status": job.jstatus
  });

  const snackBar = SnackBar(
    content: Text('Creating job ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AppPage(user: user, userType: userType)
    )
    );
  }
  catch (error){
    showAlertDialog(context);
  }
}

// Delete job request
deleteJobRequests({BuildContext context, User user, Job job, int userType}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/jobs/remove";
  FormData userData = new FormData.fromMap({
    "id": job.jid
  });

  const snackBar = SnackBar(
    content: Text('Deleting job ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AppPage(user: user, userType: userType)
    )
    );
  }
  catch (error){
    showAlertDialog(context);
  }
}

// Update job info request
updateJobRequests({BuildContext context, Job job, User user, int userType}) async {
  bool snack = true;
  Response response;
  Dio dio = new Dio();
  String url = endpoint + "/jobs/update";
  FormData userData = new FormData.fromMap({
    "id": job.jid,
    "name": job.jname,
    "description": job.jdescription,
    "status": job.jstatus
  });

  const snackBar = SnackBar(
    content: Text('Updating job details ...', style: TextStyle(color: Colors.white)),
  );
  snack ? Scaffold.of(context).showSnackBar(snackBar) : Scaffold.of(context).hideCurrentSnackBar();

  try {
    response = await dio.post(url, data: userData);
    snack = false;
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AppPage(user: user, userType: userType)
    )
    );
  }
  catch (error){
    showAlertDialog(context);
  }
}

