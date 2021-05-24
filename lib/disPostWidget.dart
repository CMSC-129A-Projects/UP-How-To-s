import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';
import 'package:uphowtos1/pseudoUser.dart';
import 'package:uphowtos1/copy.dart';
import 'package:uphowtos1/projTextStyles.dart';

class PostWidget extends StatefulWidget {
  final int index;
  final User user;
  PostWidget({this.index, this.user});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final discussion = context.watch<DiscussionList>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: maroon,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _details(discussion),
          _bottomRow(discussion),
        ],
      ),
    );
  }

  Row _bottomRow(DiscussionList discussion) => Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "Like",
                      style: subHeader01(Colors.lightBlue),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      discussion.upvoteData(widget.index, widget.user.key);
                    });
                  },
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.thumb_up,
                  color: Colors.white,
                ),
                SizedBox(width: 5.0),
                Text(
                  discussion.discussions[widget.index].data.popularity
                      .toString(),
                  style: subHeader01(Colors.white),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                SizedBox(width: 5.0),
                Text(
                  discussion.discussions[widget.index].comments.length != null
                      ? discussion.discussions[widget.index].comments.length
                          .toString()
                      : "0",
                  style: subHeader01(Colors.white),
                ),
              ],
            ),
          )
        ],
      );

  Widget _details(DiscussionList discussion) {
    double spacing = 5;
    return SizedBox(
      child: Expanded(
        child: TextButton(
          onPressed: () {},
          onLongPress: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                discussion.discussions[widget.index].data.title,
                style: header02(Colors.white),
              ),
              SizedBox(height: spacing),
              Text(
                "by " + discussion.discussions[widget.index].data.authorName,
                maxLines: null,
                style: subHeader01(Colors.white),
              ),
              SizedBox(height: spacing),
              Text(
                discussion.discussions[widget.index].data.edited
                    ? "Edited " +
                        discussion.discussions[widget.index].data.latest
                            .toString()
                    : discussion.discussions[widget.index].data.latest
                        .toString(),
                maxLines: null,
                style: subHeader02(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
