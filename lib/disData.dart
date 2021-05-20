import 'package:flutter/material.dart';

class DiscussionData{
  String title;
  String description;
  bool edited = false;
  int popularity = 0;
  DateTime latest = DateTime.now();
  String authorName;
  final Key author;

  DiscussionData(this.authorName, this.title, this.description, this.author);

  void update(String ttl, String dscrptn){
    this.title = ttl;
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