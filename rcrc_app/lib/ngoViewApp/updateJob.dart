import 'package:flutter/material.dart';
import 'package:rcrc_app/dataModels.dart';
import 'package:rcrc_app/backendRequests.dart';
import 'package:rcrc_app/constants.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class JobUpdatePage extends StatefulWidget {
  JobUpdatePage({Key key, @required this.user, @required this.job}) : super(key: key);

  final User user;
  final Job job;

  @override
  _JobUpdatePageState createState() => _JobUpdatePageState();
}

class _JobUpdatePageState extends State<JobUpdatePage> {

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
          title: Text("Update Job Details"),
          backgroundColor: appBlue,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child: MyCustomForm(user: widget.user, job: widget.job)),
      ),
    );
  }

}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {

  const MyCustomForm({Key key, @required this.user, @required this.job}) : super(key: key);

  final user;
  final job;

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
  final statusController = TextEditingController();
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

        // Status Field
        Container (
          padding: EdgeInsets.all(20),
          child: TextFormField(
            style: TextStyle(fontSize: 20.0, color: appBlue),
            controller: statusController,
            decoration: const InputDecoration(
                icon: Icon(Icons.track_changes, color: appGold),
                hintText: 'Job Status *',
                hintStyle:  TextStyle(fontSize: 20.0, color: appBlue)
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter job status';
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
                icon: Icon(Icons.description, color: appGold),
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

              var job = Job(widget.job.jid, nameController.text, descController.text, statusController.text);

              updateJobRequests(context: context, job: job, user: widget.user, userType: 1);
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
            const Text('Update', style: TextStyle(fontSize: 20)),
          ),
        ),
      );
  }
}