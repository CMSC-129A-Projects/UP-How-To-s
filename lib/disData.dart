import 'package:flutter/material.dart';

class DiscussionData{
  String title;
  String description;
  bool edited = false;
  List<Key> upVote;
  List<Key> downVote;
  int popularity = 0;
  DateTime latest = DateTime.now();
  String authorName;
  final Key author;

  DiscussionData({this.authorName, this.title, this.description, this.author});

  void update(String ttl, String dscrptn){
    this.title = ttl;
    this.description = dscrptn;
    this.edited = true;
    this.latest = DateTime.now();
  }

  void increase(Key key){
    if(upVote.indexOf(key) != -1){
      if(downVote.indexOf(key) != -1){
        downVote.remove(key);
      }
      upVote.add(key);
    } 
    else{
      upVote.remove(key);
    }
    updatePopularity();
  }

  void decrease(Key key){
    if(downVote.indexOf(key) != -1){
      if(upVote.indexOf(key) != -1){
        upVote.remove(key);
      }
        downVote.add(key);
    } 
    else{
      downVote.remove(key);
    }
    updatePopularity();
  }

  void updatePopularity(){
    popularity = upVote.length - downVote.length;
  }
}