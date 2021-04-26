import 'package:firebase_database/firebase_database.dart';
import 'staffDatabase.dart';

class Staff {
  String name;
  String department;
  String emailadd;
  String where;
  String position;
  DatabaseReference _id;

  Staff(this.name, this.department, this.emailadd, this.where, this.position);

  void update() {
    updateStaff(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'department': this.department,
      'emailadd': this.emailadd,
      'where': this.where,
      'position': this.position
    };
  }
}

Staff createStaff(record) {
  Map<String, dynamic> attributes = {
    'name': '',
    'department': '',
    'emailadd': '',
    'where': '',
    'position': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  Staff staff = new Staff(attributes['name'], attributes['department'],
      attributes['emailadd'], attributes['where'], attributes['position']);
  return staff;
}
