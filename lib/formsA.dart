import 'package:firebase_database/firebase_database.dart';
import 'formsADatabase.dart';

class FormsA {
  String body;
  String title;
  String url;
  DatabaseReference _id;

  FormsA(this.title, this.body, this.url);

  void update() {
    updateFormsA(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {'title': this.title, 'body': this.body, 'url': this.url};
  }
}

FormsA createFormsA(record) {
  Map<String, dynamic> attributes = {'title': '', 'body': '', 'url': ''};

  record.forEach((key, value) => {attributes[key] = value});

  FormsA formsA =
      new FormsA(attributes['title'], attributes['body'], attributes['url']);
  return formsA;
}
