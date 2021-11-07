import 'package:flutter/material.dart';
import 'myApplications.dart';
import 'package:rcrc_app/dataModels.dart';
import 'userProfile.dart';
import 'package:rcrc_app/constants.dart';
import 'searchJobs.dart';

class UserTab extends StatefulWidget {
  UserTab({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _UserTabState createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  List <Widget>_widgetOptions() {
    return <Widget>[
      UserPage(key: PageStorageKey('UserPage'), user: widget.user, userType: 0),
      MainFetchJobs(key: PageStorageKey('SearchJobs'), user: widget.user),
      Container (
          child: MainFetchApps(key: PageStorageKey('MyJobApplications'), user: widget.user)
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: _widgetOptions().elementAt(_selectedIndex),
        bucket: bucket,
      ),

      bottomNavigationBar: Container (
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
      child: BottomNavigationBar(
        elevation: 15.0,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('My Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Find Jobs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            title: Text('My Applications'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: appBlue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      ),
    );
  }
}

