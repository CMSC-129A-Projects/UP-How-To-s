import 'package:flutter/material.dart';
import 'package:uphowtos1/disData.dart';
import 'package:uphowtos1/disComData.dart';

class DiscussionBlock {
  DiscussionData data;
  List<CommentData> comments = [];

  DiscussionBlock(this.data);

  void update(String title, String description) {
    this.data.update(title, description);
  }

  void updateComments(String description, int index) {
    this.comments[index].update(description);
  }

  void upvoteData(Key key) {
    this.data.increase(key);
  }

  void addComments(CommentData d) {
    this.comments.add(d);
  }

  void removeComments(int index) {
    this.comments.removeAt(index);
  }

  void upvoteComment(int index, Key key) {
    this.comments[index].increase(key);
  }
}
