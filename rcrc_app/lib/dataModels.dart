
class User {

  final String uid;
  final String uname;
  final String ucontact;

  User(this.uid, this.uname, this.ucontact);

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
        json['id'],
        json['name'],
        json['contact']
    );
  }

}

class Job {

  final String jid;
  final String jname;
  final String jdescription;
  final String jstatus;

  Job(this.jid, this.jname, this.jdescription, this.jstatus);

  factory Job.fromJson(Map<String, dynamic> json) {
    return new Job(
      json['id'],
      json['name'],
      json['description'],
      json['status']
    );
  }

}

class Application {

  final String jobid;
  final String userid;
  final String astatus;

  Application(this.jobid, this.userid, this.astatus);

  factory Application.fromJson(Map<String, dynamic> json) {
    return new Application(
        json['job'],
        json['user'],
        json['status']
    );
  }

}