import 'package:firebase_database/firebase_database.dart';
import 'formsNDatabase.dart';

class FormsN {
  String body;
  String title;
  String url;
  DatabaseReference _id;

  FormsN(this.title, this.body, this.url);

  void update() {
    updateFormsN(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {'title': this.title, 'body': this.body, 'url': this.url};
  }
}

FormsN createFormsN(record) {
  Map<String, dynamic> attributes = {'title': '', 'body': '', 'url': ''};

  record.forEach((key, value) => {attributes[key] = value});

  FormsN formsN =
      new FormsN(attributes['title'], attributes['body'], attributes['url']);
  return formsN;
}
