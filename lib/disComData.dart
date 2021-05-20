import 'package:flutter/material.dart';

class CommentData{
  String description;
  int popularity = 0;
  bool edited = false;
  DateTime latest = DateTime.now();
  final Key author;
  final String authorName;

  CommentData(this.authorName, this.description, this.author);

  void update(String dscrptn){
    this.description = dscrptn;
    this.edited = true;
    this.latest = DateTime.now();
  }

  void increase(){
    this.popularity++;
  }

  void decrease(){
    this.popularity--;
  }
}