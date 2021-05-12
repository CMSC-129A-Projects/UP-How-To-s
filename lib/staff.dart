import 'package:firebase_database/firebase_database.dart';
import 'staffDatabase.dart';

class Staff {
  String name;
  String location;
  String position;
  String email;
  String department;

  DatabaseReference _id;

  Staff(this.name, this.location, this.position, this.email, this.department);

  void update() {
    updateStaff(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'location': this.location,
      'position': this.position,
      'email': this.email,
      'department': this.department
    };
  }
}

Staff createStaff(record) {
  Map<String, dynamic> attributes = {
    'name': '',
    'location': '',
    'position': '',
    'email': '',
    'department': ''
  };
  record.forEach((key, value) => {attributes[key] = value});

  Staff staff = new Staff(attributes['name'], attributes['location'],
      attributes['position'], attributes['email'], attributes['department']);
  return staff;
}
