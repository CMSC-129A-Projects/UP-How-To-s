import 'package:flutter/material.dart';

class CommentData {
  String description;
  bool edited = false;
  int popularity = 0;
  DateTime latest = DateTime.now();
  final Key author;

  CommentData(this.description, this.author);

  void update(String dscrptn) {
    this.description = dscrptn;
    this.edited = true;
    this.latest = DateTime.now();
  }

  void increase() {
    this.popularity++;
  }

  void decrease() {
    this.popularity--;
  }
}
