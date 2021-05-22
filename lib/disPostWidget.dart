import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';
import 'package:uphowtos1/pseudoUser.dart';
import 'package:uphowtos1/copy.dart';

class PostWidget extends StatelessWidget {

  final int index;
  final User user;
  PostWidget({this.index, this.user});

  @override
  Widget build(BuildContext context) {
    final discussion = context.watch<DiscussionList>();
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: maroon,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey, 
            blurRadius: 6, 
            offset: Offset(0, 4),
          ),
        ],
      ),
      color: maroon,
      child: Row(
        children: <Widget> [
          _vote(discussion),
          _details(discussion),
        ],
      ),
    );
  }

  Column _vote(DiscussionList discussion) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.arrow_upward
            ), 
            onPressed: () => {
              discussion.discussions[index].upvoteData(user.key)
            }
        ),
        Text(
          discussion.discussions[index].data.popularity.toString(),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_downward
          ), 
          onPressed: () => {
            discussion.discussions[index].downvoteData(user.key)
          }
        )
      ],
    );
  }

  Column _details(DiscussionList discussion) {
    double spacing = 5;
    return Column(
      children: <Widget> [
        Text(
          discussion.discussions[index].data.title,
          maxLines: null,
          style: TextStyle(
            fontFamily: 'Helvetica-Bold',
            fontSize: 18,
            color: Colors.white,
          )
        ),
        SizedBox(height: spacing),
        Text(
          "by" + discussion.discussions[index].data.authorName,
          style: TextStyle(
            fontFamily: 'Helvetica-Light',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          discussion.discussions[index].data.edited ? "Edited " + discussion.discussions[index].data.latest.toString() : discussion.discussions[index].data.latest.toString(),
          style: TextStyle(
            fontFamily: 'Helvetica-Light',
            fontSize: 14,
            color:  Colors.white,
          )
        ),
      ],
    );
  }
}