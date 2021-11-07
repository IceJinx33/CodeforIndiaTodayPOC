import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/userViewApp/userProfile.dart';
import 'package:rcrc_app/constants.dart';
import 'ngoJobs.dart';

class NGOTab extends StatefulWidget {
  NGOTab({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _NGOTabState createState() => _NGOTabState();
}

class _NGOTabState extends State<NGOTab> {
  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  List <Widget>_widgetOptions() {
    return <Widget>[
      UserPage(key: PageStorageKey('UserPageNGO'), user: widget.user, userType: 1),
      NGOJobs(key: PageStorageKey('JobPageNGO'), user: widget.user)
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
              title: Text('Job List'),
            )
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
