/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'disList.dart';
import 'pseudoUser.dart';
import '../projTextStyles.dart';
import 'disPostPage.dart';
import 'package:uphowtos1/others.dart/disNewPost.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

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
      padding: EdgeInsets.only(bottom: 0, top: 12, left: 10, right: 10),
      // padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: maroon,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          // _moreMenu(discussion),
          _details(discussion),
          _bottomRow(discussion),
        ],
      ),
    );
  }

  Row _bottomRow(DiscussionList discussion) => Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                ),
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    discussion.discussions[widget.index]
                            .doesExist(widget.user.key)
                        ? "Unlike"
                        : "Like",
                    style: subHeader01(Colors.white),
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.thumb_up,
                  color: Colors.white,
                  size: 20,
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
                  size: 20,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5, right: 10),
                child: CircleAvatar(
                  child: Text("JE"),
                  backgroundColor: Colors.grey.shade400,
                  foregroundColor: Colors.white,
                  radius: 30.0,
                ),
              ),
              Expanded(
                flex: 10,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      setState(
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiscussionPostPage(
                                user: widget.user,
                                index: widget.index,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          discussion.discussions[widget.index].data.title,
                          style: header02(Colors.white),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          "by " +
                              discussion
                                  .discussions[widget.index].data.authorName,
                          maxLines: null,
                          style: subHeader01(Colors.white),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          discussion.discussions[widget.index].data.edited
                              ? "Edited " +
                                  discussion
                                      .discussions[widget.index].data.latest
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
              ),
              _moreMenu(discussion),
            ],
          ),
        ),
      ],
    );
  }

  Widget _moreMenu(DiscussionList discussion) {
    return PopupMenuButton<int>(
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      onSelected: (item) {
        switch (item) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiscussionAddPost.toEdit(
                  user: widget.user,
                  index: widget.index,
                  ttl: discussion.discussions[widget.index].data.title,
                  des: discussion.discussions[widget.index].data.description,
                ),
              ),
            );
            break;
          case 1:
            discussion.remove(widget.index);
            break;
        }
      },
      itemBuilder: (context) => [
        // edit is only open to the author of the comment
        PopupMenuItem<int>(
          enabled: discussion.discussions[widget.index].data.author ==
                  widget.user.key
              ? true
              : false,
          value: 0,
          child: Text('Edit'),
        ),
        // remove is enabled only to the author of the comment, post and admin
        PopupMenuItem<int>(
          enabled: (discussion.discussions[widget.index].data.author ==
                      widget.user.key) ||
                  (adminPseudoKey() == widget.user.key)
              ? true
              : false,
          value: 1,
          child: Text('Remove'),
        ),
      ],
    );
  }
}
*/