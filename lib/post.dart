/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postDatabase.dart';

class Post {
  String body;
  String author;
  Set usersLiked = {};
  DatabaseReference _id;

  Post(this.body, this.author);

  void likePost(FirebaseUser user) {
    if (this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    this.update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': this.author,
      'usersLiked': this.usersLiked.toList(),
      'body': this.body
    };
  }
}

Post createPost(record) {
  Map<String, dynamic> attributes = {
    'author': '',
    'usersLiked': [],
    'body': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  Post post = new Post(attributes['body'], attributes['author']);
  post.usersLiked = new Set.from(attributes['usersLiked']);
  return post;
}

*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postDatabase.dart';
import 'comments.dart';

class Post {
  String body;
  String author;
  String title;
  String date;
  bool edit;
  Set usersLiked = {};
  List<String> keywords;
  List<Comment> comments;
  DatabaseReference _id;

  Post(this.author, this.body, this.comments, this.date, this.edit,
      this.keywords, this.title);

  void likePost(User user) {
    if (this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    this.update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'author': this.author,
      'body': this.body,
      'comments': this.comments,
      'date': this.date,
      'edit': this.edit,
      'keywords': this.keywords,
      'title': this.title,
      'usersLiked': this.usersLiked.toList(),
    };
  }
}

Post createPost(record) {
  List<Comment> comments;
  List<String> keywords;
  Map<dynamic, dynamic> attributes = {
    'author': '',
    'body': '',
    'comments': comments,
    'date': '',
    'edit': '',
    'keywords': keywords,
    'title': '',
    'usersLiked': [],
  };

  record.forEach((key, value) => {attributes[key] = value});

  record.forEach((key, value) => {attributes[key] = value});
  Post post = new Post(
    attributes['author'],
    attributes['body'],
    attributes[comments],
    attributes['date'],
    attributes['edit'],
    attributes[keywords],
    attributes['title'],
  );
  post.usersLiked = new Set.from(attributes['usersLiked']);
  return post;
}
