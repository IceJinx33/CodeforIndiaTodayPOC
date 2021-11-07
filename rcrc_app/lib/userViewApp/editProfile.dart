import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/backendRequests.dart';
import 'package:rcrc_app/constants.dart';

class MyEditPage extends StatefulWidget {
  MyEditPage({Key key, @required this.user, @required this.userType}) : super(key: key);

  final user;
  final userType;

  @override
  _MyEditPageState createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Edit Profile",
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text("Edit Profile"),
          backgroundColor: appBlue,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child: MyCustomForm(user: widget.user, userType: widget.userType)),
      ),
    );
  }

}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {

  const MyCustomForm({Key key, @required this.user, @required this.userType}) : super(key: key);

  final user;
  final userType;

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

  final nameController = TextEditingController();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: _buildForm()
    );
  }

  Widget _buildForm() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

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

              var user = User(widget.user.uid, nameController.text, contactController.text);

              updateUserRequests(context: context, user: user, userType: widget.userType);
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
