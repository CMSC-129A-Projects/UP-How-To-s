import 'package:firebase_database/firebase_database.dart';
import 'formsDatabase.dart';

class Forms {
  List<String> body;
  String title;
  String url;
  String desc;
  DatabaseReference _id;

  Forms(this.title, this.body, this.url, this.desc);

  void update() {
    updateForms(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'body': this.body,
      'url': this.url,
      'desc': this.desc
    };
  }
}

Forms createForms(record) {
  List<String> body = [];
  Map<String, dynamic> attributes = {
    'title': '',
    'body': body,
    'url': '',
    'desc': '',
  };
  record.forEach((key, value) => {attributes[key] = value});

  Forms forms = new Forms(attributes['title'], attributes[body],
      attributes['url'], attributes['desc']);
  return forms;
}
