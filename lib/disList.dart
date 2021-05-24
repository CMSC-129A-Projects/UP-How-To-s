import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:uphowtos1/disBlockData.dart';

class DiscussionList extends ChangeNotifier {
  List<DiscussionBlock> discussions = [];

  void addDiscussion(DiscussionBlock discussion) {
    this.discussions.add(discussion);
    notifyListeners();
  }

  void update(String title, String description, int index) {
    this.discussions[index].update(title, description);
    notifyListeners();
  }

  void updateComments(String description, int disIndex, int comIndex) {
    this.discussions[disIndex].updateComments(description, comIndex);
    notifyListeners();
  }

  Future<void> remove(int index) async {
    this.discussions.removeAt(index);
    notifyListeners();
  }

  Future<void> removeComments(int disIndex, int comIndex) async {
    this.discussions[disIndex].removeComments(comIndex);
    notifyListeners();
  }

  Future<void> upvoteData(int index, Key key) async {
    this.discussions[index].upvoteData(key);
    notifyListeners();
  }

  Future<void> upvoteComment(int disIndex, int comIndex, Key key) async {
    this.discussions[disIndex].upvoteComment(comIndex, key);
    notifyListeners();
  }
}
