import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'commentsDatabase.dart';

class Comment {
  String body;
  String author;
  String date;
  bool edit;
  Set usersLiked = {};
  DatabaseReference _id;

  Comment(this.body, this.author, this.date, this.edit);

  void likePost(FirebaseUser user) {
    if (this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    // this.update();
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
