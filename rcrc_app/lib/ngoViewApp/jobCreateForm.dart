import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/backendRequests.dart';
import 'package:rcrc_app/constants.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class JobCreatePage extends StatefulWidget {
  JobCreatePage({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _JobCreatePageState createState() => _JobCreatePageState();
}

class _JobCreatePageState extends State<JobCreatePage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Create Job",
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
          title: Text("Create Job"),
          backgroundColor: appBlue,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child: MyCustomForm(user: widget.user)),
      ),
    );
  }

}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {

  const MyCustomForm({Key key, @required this.user}) : super(key: key);

  final user;

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
  final descController = TextEditingController();

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
                icon: Icon(Icons.business, color: appGold),
                hintText: 'Job Name *',
                hintStyle:  TextStyle(fontSize: 20.0, color: appBlue)
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter job name';
              }
              return null;
            },
          ),
        ),

        // Description Field
        Container (
          padding: EdgeInsets.all(20),
          child: TextFormField(
            style: TextStyle(fontSize: 20.0, color: appBlue),
            controller: descController,
            decoration: const InputDecoration(
                icon: Icon(Icons.subject, color: appGold),
                hintText: 'Job Description *',
                hintStyle:  TextStyle(fontSize: 20.0, color: appBlue)
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a job description';
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

              var job = Job(uuid.v4(), nameController.text, descController.text, "Available");

              postJobRequests(context: context, job: job, user: widget.user, userType: 1);
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
            const Text('Create', style: TextStyle(fontSize: 20)),
          ),
        ),
      );
  }
}