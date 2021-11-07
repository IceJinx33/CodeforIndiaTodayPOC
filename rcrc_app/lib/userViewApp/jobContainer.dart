import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/constants.dart';
import 'package:rcrc_app/ngoViewApp/ngoJobDisplay.dart';
import 'jobDisplay.dart';

Widget buildJobContainer (BuildContext context, Job job, User user, int userType) {
  return
    new InkWell(
      onTap: () {
        if (userType == 0) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => JobPage(job: job, user: user)
          )
          );
        }
        else {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => NGOJobPage(job: job, user: user)
          )
          );
        }
      },
      child: Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(color: Colors.white, spreadRadius: 3.0)]),
    child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           Container(
               height: 120.0,
               decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                boxShadow: [BoxShadow(color: accBlue)]
               ),
               child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget> [
                     Center (
                        child: Icon(Icons.work, color: Colors.white, size: 50.0)
                     ),
                     ]
               ),
           ),
           const SizedBox(height: 5),
           Container (
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                        Text(job.jname, style: TextStyle(fontSize: 20.0, color: appBlue, fontWeight: FontWeight.bold)),
                        Text(job.jstatus, style: TextStyle(fontSize: 20.0, color: appGold, fontWeight: FontWeight.bold))
                    ]
                ),
           ),
           const SizedBox(height: 5),
           Container (
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                        Text(job.jdescription, style: TextStyle(fontSize: 15.0, color: Colors.grey))
                    ]
                )
           )
         ],
        )
      ),
  );
}