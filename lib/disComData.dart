import 'package:flutter/material.dart';

class CommentData {
  String description;
  List<Key> upVote = [];
  int popularity = 0;
  bool edited = false;
  DateTime latest = DateTime.now();
  final Key author;
  final String authorName;

  CommentData(this.authorName, this.description, this.author);

  bool doesExist(Key key) {
    return upVote.indexOf(key) != -1;
  }

  void update(String dscrptn) {
    this.description = dscrptn;
    this.edited = true;
    this.latest = DateTime.now();
  }

  void increase(Key key) {
    if (!this.doesExist(key)) {
      upVote.add(key);
      this.popularity++;
    } else {
      upVote.remove(key);
      this.popularity--;
    }
  }
}
