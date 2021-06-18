import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postDatabase.dart';

class Post {
  String nickname;
  String body;
  String author;
  String title;
  String date;
  bool edit;
  Set usersLiked = {};
  Set usersFlagged = {};
  int likenum = 0;
  int flagnum = 0;
  String keywords;
  DatabaseReference _id;

  Post(this.nickname, this.author, this.body, this.date, this.edit,
      this.keywords, this.title, this.likenum, this.flagnum);

  void flagPost(User user) {
    if (this.usersFlagged.contains(user.uid)) {
    } else {
      this.usersFlagged.add(user.uid);
      this.flagnum = this.flagnum + 1;
    }
    this.update();
  }

  void likePost(User user) {
    if (this.usersLiked.contains(user.uid)) {
      this.likenum = this.likenum - 1;
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
      this.likenum = this.likenum + 1;
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
      'nickname': this.nickname,
      'author': this.author,
      'body': this.body,
      'date': this.date,
      'edit': this.edit,
      'keywords': this.keywords,
      'title': this.title,
      'usersLiked': this.usersLiked.toList(),
      'usersFlagged': this.usersFlagged.toList(),
      'likenum': this.likenum,
      'flagnum': this.flagnum,
    };
  }
}

Post createPosts(record) {
  Map<String, dynamic> attributes = {
    'nickname': '',
    'author': '',
    'body': '',
    'date': '',
    'edit': false,
    'keywords': '',
    'title': '',
    'usersLiked': [],
    'usersFlagged': [],
    'likenum': 0,
    'flagnum': 0,
  };

  record.forEach((key, value) => {attributes[key] = value});

  Post posts = new Post(
      attributes['nickname'],
      attributes['author'],
      attributes['body'],
      attributes['date'],
      attributes['edit'],
      attributes['keywords'],
      attributes['title'],
      attributes['likenum'],
      attributes['flagnum']);
  posts.usersLiked = new Set.from(attributes['usersLiked']);
  posts.usersFlagged = new Set.from(attributes['usersFlagged']);
  return posts;
}

class Comment {
  String nickname = '';
  String body = '';
  String author = '';
  String date = '';
  bool edit = false;
  Set usersLiked = {};
  Set usersFlagged = {};
  int likenum = 0;
  int flagnum = 0;
  DatabaseReference _id;

  Comment(this.nickname, this.author, this.body, this.date, this.edit,
      this.likenum, this.flagnum);

  void flagComment(User user) {
    if (this.usersFlagged.contains(user.uid)) {
    } else {
      this.usersFlagged.add(user.uid);
      this.flagnum = this.flagnum + 1;
    }
    this.update();
  }

  void likeComment(User user) {
    if (this.usersLiked.contains(user.uid)) {
      this.likenum = this.likenum - 1;
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
      this.likenum = this.likenum + 1;
    }
    this.update();
  }

  void update() {
    updateComment(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  String giveId() {
    return this._id.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': this.nickname,
      'author': this.author,
      'body': this.body,
      'date': this.date,
      'edit': this.edit,
      'usersLiked': this.usersLiked.toList(),
      'usersFlagged': this.usersFlagged.toList(),
      'likenum': this.likenum,
      'flagnum': this.flagnum,
    };
  }
}

Comment createComments(record) {
  Map<String, dynamic> attributes = {
    'nickname': '',
    'author': '',
    'body': '',
    'date': '',
    'edit': false,
    'usersLiked': [],
    'usersFlagged': [],
    'likenum': 0,
    'flagnum': 0,
  };

  record.forEach((key, value) => {attributes[key] = value});

  Comment comments = new Comment(
      attributes['nickname'],
      attributes['author'],
      attributes['body'],
      attributes['date'],
      attributes['edit'],
      attributes['likenum'],
      attributes['flagnum']);
  comments.usersLiked = new Set.from(attributes['usersLiked']);
  comments.usersFlagged = new Set.from(attributes['usersFlagged']);
  return comments;
}
