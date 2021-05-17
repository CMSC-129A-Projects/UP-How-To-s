import 'package:flutter/material.dart';
import 'package:uphowtos1/disBlockData.dart';

class DiscussionList extends ChangeNotifier{
  List<DiscussionBlock> discussions;

  void update(String title, String description, int index){
    this.discussions[index].update(title, description);
    notifyListeners();
  }

  void updateComments(String description, int disIndex, int comIndex){
    this.discussions[disIndex].updateComments(description, comIndex);
    notifyListeners();
  }

  void remove(int index){
    this.discussions.removeAt(index);
    notifyListeners();
  }

  void removeComments(int disIndex, int comIndex){
    this.discussions[disIndex].removeComments(comIndex);
    notifyListeners();
  }

  void upvoteData(int index){
    this.discussions[index].upvoteData();
    notifyListeners();
  }

  void downvoteData(int index){
    this.discussions[index].downvoteData();
    notifyListeners();
  }

  void upvoteComment(int disIndex, int comIndex){
    this.discussions[disIndex].upvoteComment(comIndex);
    notifyListeners();
  }

  void downvoteComment(int disIndex, int comIndex){
    this.discussions[disIndex].upvoteComment(comIndex);
    notifyListeners();
  }
}