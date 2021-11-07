import 'package:flutter/material.dart';
import 'dataModels.dart';
import 'backendRequests.dart';
import 'main.dart';
import 'constants.dart';

class MySignInPage extends StatefulWidget {
  MySignInPage({Key key}) : super(key: key);

  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Create Profile",
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyApp()
              )
              );
            },
          ),
          centerTitle: true,
          title: Text("Create Profile"),
          backgroundColor: appBlue,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child: MyCustomForm()),
      ),
    );
  }

}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {

  const MyCustomForm({Key key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  var _radioValue = -1;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: _buildForm()
    );
  }

  Widget _buildForm() {

    void handleRadio(value) {
      setState(() {
        _radioValue = value;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

    // ID
       Container (
          padding: EdgeInsets.all(20),
          child: TextFormField(
            style: TextStyle(fontSize: 20.0, color: appBlue),
            controller: idController,
            decoration: const InputDecoration(
                icon: Icon(Icons.lock_outline, color: appGold),
                hintText: 'User ID *',
                hintStyle:  TextStyle(fontSize: 20.0, color: appBlue)
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your user ID';
              }
              return null;
            },
          )
       ),

        // Name Field
       Container (
            padding: EdgeInsets.all(20),
            child: TextFormField(
              style: TextStyle(fontSize: 20.0, color: appBlue),
              controller: nameController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person, color: appGold),
                  hintText: 'Name *',
                  hintStyle:  TextStyle(fontSize: 20.0, color: appBlue)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),

        // Phone Number Field
        Container (
            padding: EdgeInsets.all(20),
            child: TextFormField(
              style: TextStyle(fontSize: 20.0, color: appBlue),
              controller: contactController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.phone, color: appGold),
                  hintText: 'Phone Number *',
                  hintStyle:  TextStyle(fontSize: 20.0, color: appBlue)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
          ),

        Container (
          padding: EdgeInsets.all(20),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                  value: 0,
                  activeColor: appGold,
                  groupValue: _radioValue,
                  onChanged: handleRadio
              ),
              Text("User", style: TextStyle(fontSize: 20, color: appBlue)),
              const SizedBox(width: 50),
              Radio(
                  value: 1,
                  activeColor: appGold,
                  groupValue: _radioValue,
                  onChanged: handleRadio
              ),
              Text("NGO", style: TextStyle(fontSize: 20, color: appBlue))
            ],
          )
        ),

        const SizedBox(height: 50),
        _submitButton(),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _submitButton() {
    return
      Center (
        child: RaisedButton(
          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {

              var user = User(idController.text, nameController.text, contactController.text);

              postUserRequests(context: context, user: user, userType: _radioValue);
            }
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
                color: appGold
            ),
            padding: const EdgeInsets.all(15.0),
            child:
            const Text('Submit', style: TextStyle(fontSize: 20)),
          ),
        ),
    );
  }
}
