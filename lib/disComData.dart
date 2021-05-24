import 'package:flutter/material.dart';

class CommentData {
  String description;
  List<Key> upVote;
  bool edited = false;
  DateTime latest = DateTime.now();
  final Key author;
  final String authorName;

  CommentData(this.authorName, this.description, this.author);

  void update(String dscrptn) {
    this.description = dscrptn;
    this.edited = true;
    this.latest = DateTime.now();
  }

  void increase(Key key) {
    if (upVote.indexOf(key) != null) {
      upVote.add(key);
    } else {
      upVote.remove(key);
    }
  }
}
