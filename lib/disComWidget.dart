import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';
import 'package:uphowtos1/pseudoUser.dart';
import 'package:uphowtos1/projTextStyles.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

// ignore: must_be_immutable
class DiscussionComWidget extends StatefulWidget {
  final int dataIndex;
  final int comIndex;
  final User user;
  TextEditingController desc = TextEditingController();
  bool editState = false;
  DiscussionComWidget(
      {@required this.dataIndex, @required this.comIndex, @required this.user});

  @override
  _DiscussionComWidgetState createState() => _DiscussionComWidgetState();
}

class _DiscussionComWidgetState extends State<DiscussionComWidget> {
  @override
  Widget build(BuildContext context) {
    DiscussionList dis = context.watch<DiscussionList>();

    if (widget.editState) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset.fromDirection(90, 5),
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            _comHeaderEdit(dis),
            _editText(dis),
            _submitButton(dis),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset.fromDirection(90, 5),
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            _comHeader(dis),
            _comDetails(dis),
            _bottomDetails(dis),
          ],
        ),
      );
    }
  }

  Widget _comHeader(DiscussionList dis) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: CircleAvatar(
            child: Text("JE"),
            backgroundColor: Colors.grey.shade400,
            foregroundColor: Colors.white,
            radius: 25.0,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                child: Expanded(
                  child: Text(
                    dis.discussions[widget.dataIndex].comments[widget.comIndex]
                        .authorName,
                    style: subHeader01(maroon),
                    maxLines: null,
                  ),
                ),
              ),
              Text(
                dis.discussions[widget.dataIndex].comments[widget.comIndex]
                        .edited
                    ? "Edited ${dis.discussions[widget.dataIndex].comments[widget.comIndex].latest.toString()}"
                    : "${dis.discussions[widget.dataIndex].comments[widget.comIndex].latest.toString()}",
                style: subHeader02(maroon),
              ),
            ],
          ),
        ),
        PopupMenuButton<int>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          onSelected: (item) {
            switch (item) {
              case 0:
                setState(() {
                  widget.editState = true;
                });
                break;
              case 1:
                dis.removeComments(widget.dataIndex, widget.comIndex);
                break;
            }
          },
          itemBuilder: (context) => [
            // edit is only open to the author of the comment
            PopupMenuItem<int>(
              enabled: dis.discussions[widget.dataIndex]
                          .comments[widget.comIndex].author ==
                      widget.user.key
                  ? true
                  : false,
              value: 0,
              child: Text('Edit'),
            ),
            // remove is enabled only to the author of the comment, post and admin
            PopupMenuItem<int>(
              enabled: (dis.discussions[widget.dataIndex]
                              .comments[widget.comIndex].author ==
                          widget.user.key) ||
                      (dis.discussions[widget.dataIndex].data.author ==
                          widget.user.key) ||
                      (adminPseudoKey() == widget.user.key)
                  ? true
                  : false,
              value: 1,
              child: Text('Remove'),
            ),
          ],
        )
      ],
    );
  }

  Widget _comDetails(DiscussionList dis) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          dis.discussions[widget.dataIndex].comments[widget.comIndex]
              .description,
          style: bodyText(maroon),
        ),
      ),
    );
  }

  Widget _bottomDetails(DiscussionList dis) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      padding: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      dis.discussions[widget.dataIndex]
                              .comments[widget.comIndex]
                              .doesExist(widget.user.key)
                          ? "Unlike"
                          : "Like",
                      style: subHeader01(maroon),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      dis.upvoteComment(
                          widget.dataIndex, widget.comIndex, widget.user.key);
                    });
                  },
                ),
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
                  color: maroon,
                  size: 20,
                ),
                SizedBox(width: 5.0),
                Text(
                  dis.discussions[widget.dataIndex].comments[widget.comIndex]
                      .popularity
                      .toString(),
                  style: subHeader01(maroon),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _comHeaderEdit(DiscussionList dis) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: CircleAvatar(
            child: Text("JE"),
            backgroundColor: Colors.grey.shade400,
            foregroundColor: Colors.white,
            radius: 25.0,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                child: Expanded(
                  child: Text(
                    dis.discussions[widget.dataIndex].comments[widget.comIndex]
                        .authorName,
                    style: subHeader01(maroon),
                    maxLines: null,
                  ),
                ),
              ),
              Text(
                dis.discussions[widget.dataIndex].comments[widget.comIndex]
                        .edited
                    ? "Edited ${dis.discussions[widget.dataIndex].comments[widget.comIndex].latest.toString()}"
                    : "${dis.discussions[widget.dataIndex].comments[widget.comIndex].latest.toString()}",
                style: subHeader02(maroon),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editText(DiscussionList dis) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        controller: widget.desc
          ..text = dis.discussions[widget.dataIndex].comments[widget.comIndex]
              .description,
        style: bodyText(maroon),
        maxLines: null,
        decoration: InputDecoration(
          hintText: "What do you think about it?",
          hintStyle: TextStyle(
            fontFamily: "Helvetica-Oblique",
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _submitButton(DiscussionList dis) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: OutlinedButton(
        child: Text(
          'Submit',
          style: subHeader01(maroon),
        ),
        onPressed: () {
          dis.updateComments(
            widget.desc.text,
            widget.dataIndex,
            widget.comIndex,
          );
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: maroon),
        ),
      ),
    );
  }
}
