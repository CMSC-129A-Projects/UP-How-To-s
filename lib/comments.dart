import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'commentsDatabase.dart'; /temporarily hidden, uncomment it so that it will work

class Comment {
  String body;
  String author;
  String date;
  bool edit;
  Set usersLiked = {};
  DatabaseReference _id;

  Comment(this.body, this.author, this.date, this.edit);

  void likePost(User user) {
    if (this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    //this.update();
  }

/*

  void update() {
    updateComment(this, this._id);
  }
*/
  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'author': this.author,
      'usersLiked': this.usersLiked.toList(),
      'body': this.body,
      'date': this.date,
      'edit': this.edit,
      'ID': this
          ._id //this is to make sure that _id is being used, but there's no need to use this, this just to make sure there's no error -Marc
    };
  }
}

Comment createPost(record) {
  Map<dynamic, dynamic> attributes = {
    'author': '',
    'usersLiked': [],
    'body': '',
    'date': '',
    'edit': '',
  };

  record.forEach((key, value) => {attributes[key] = value});

  Comment comment = new Comment(attributes['author'], attributes['body'],
      attributes['date'], attributes['edit']);
  comment.usersLiked = new Set.from(attributes['usersLiked']);
  return comment;
}

/*name: CI
on:
  pull_request:
    branches:
      - main
  
jobs:
  flutter_test:
    name: Run flutter test and analyze
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v1
        with:
          java-version: "12.x"
      - uses: subosito/flutter-action@v1
        with:
          channel: "stable"
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      */
