import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:uphowtos1/disBlockData.dart';
import 'package:uphowtos1/disComData.dart';

class DiscussionList extends ChangeNotifier {
  List<DiscussionBlock> discussions = [];

  void addDiscussion(DiscussionBlock discussion) {
    this.discussions.add(discussion);
    notifyListeners();
  }

  void upvoteData(int index, Key key) {
    this.discussions[index].upvoteData(key);
    notifyListeners();
  }

  void update(String title, String description, int index) {
    this.discussions[index].update(title, description);
    notifyListeners();
  }

  void remove(int index) {
    this.discussions.removeAt(index);
    notifyListeners();
  }

  void addComment(
      {String description, int disIndex, Key key, String authorName}) {
    this
        .discussions[disIndex]
        .addComments(CommentData(authorName, description, key));
    notifyListeners();
  }

  void upvoteComment(int disIndex, int comIndex, Key key) {
    this.discussions[disIndex].upvoteComment(comIndex, key);
    notifyListeners();
  }

  void updateComments(String description, int disIndex, int comIndex) {
    this.discussions[disIndex].updateComments(description, comIndex);
    notifyListeners();
  }

  void removeComments(int disIndex, int comIndex) {
    this.discussions[disIndex].removeComments(comIndex);
    notifyListeners();
  }
}
