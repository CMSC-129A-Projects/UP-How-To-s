import 'package:firebase_database/firebase_database.dart';
import 'orgsDatabase.dart';

class Orgs {
  List<String> officers;
  String name;
  String desc;
  String contactinfo;
  DatabaseReference _id;

  Orgs(this.name, this.officers, this.contactinfo, this.desc);

  void update() {
    updateOrgs(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'officers': this.officers,
      'contactinfo': this.contactinfo,
      'desc': this.desc
    };
  }
}

Orgs createOrgs(record) {
  List<String> officers = [];
  Map<String, dynamic> attributes = {
    'name': '',
    'officers': officers,
    'contactinfo': '',
    'desc': '',
  };
  record.forEach((key, value) => {attributes[key] = value});

  Orgs orgs = new Orgs(attributes['name'], attributes[officers],
      attributes['contactinfo'], attributes['desc']);
  return orgs;
}
