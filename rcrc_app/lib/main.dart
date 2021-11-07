import 'package:flutter/material.dart';
import 'signIn.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RCRC App',
      theme: ThemeData(
        // This is the theme of your application.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageState(),
        '/signin': (context) => MySignInPage()
      },
    );
  }
}

class HomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('RCRC Home Page')),
          backgroundColor: appBlue
        ),
        // body is the majority of the screen.
        body: Container (
          color: Colors.white,
          child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container (
              padding:  const EdgeInsets.all(20.0),
              child: Center(
                  child: Image(image: AssetImage('images/rcrclogo.png'))
              ),
            ),
            continueButton(context)
              ]
            ),
          ),
    );
  }

  Widget continueButton(BuildContext context) {
    return Container (
      padding: const EdgeInsets.all(50.0),
      child: Center (
      child: RaisedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/signin');
        },
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
              color: appGold
          ),
          padding: const EdgeInsets.all(10.0),
          child:
          const Text('Continue', style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}





