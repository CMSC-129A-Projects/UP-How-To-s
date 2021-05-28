import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';
import 'package:uphowtos1/pseudoUser.dart';
import 'package:uphowtos1/copy.dart';
import 'package:uphowtos1/projTextStyles.dart';
import 'package:uphowtos1/disNewPost.dart';
import 'package:uphowtos1/disComWidget.dart';

// ignore: must_be_immutable
class DiscussionPostPage extends StatefulWidget {
  final User user;
  final int index;

  DiscussionPostPage({@required this.user, @required this.index});

  TextEditingController addCom = TextEditingController();

  @override
  _DiscussionPostPageState createState() => _DiscussionPostPageState();
}

class _DiscussionPostPageState extends State<DiscussionPostPage> {
  @override
  Widget build(BuildContext context) {
    final dis = context.watch<DiscussionList>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: maroon),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: _actionDetail(dis),
        ),
        body: SingleChildScrollView(
          child: _body(context, dis),
          physics: ScrollPhysics(),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, DiscussionList dis) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _header(dis),
          _details(dis),
          _bottomDetails(dis),
          _commentDivider(),
          _addComment(dis),
          _comments(context, dis),
        ],
      ),
    );
  }

  Widget _header(DiscussionList dis) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              child: Text("JE"),
              backgroundColor: Colors.grey.shade400,
              foregroundColor: Colors.white,
              radius: 35.0,
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
                      widget.user.name,
                      style: subHeader01(maroon),
                      maxLines: null,
                    ),
                  ),
                ),
                Text(
                  dis.discussions[widget.index].data.latest.toString(),
                  style: subHeader02(maroon),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _details(DiscussionList dis) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            dis.discussions[widget.index].data.title,
            style: header01(maroon),
          ),
          SizedBox(height: 10),
          Text(
            dis.discussions[widget.index].data.description,
            style: bodyText(maroon),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  List<Widget> _actionDetail(DiscussionList dis) {
    List<Widget> widgets = [];
    List<Key> hasAccess = [];
    hasAccess.add(admin);
    hasAccess.add(dis.discussions[widget.index].data.author);

    if (hasAccess.indexOf(widget.user.key) != -1) {
      widgets.add(
        IconButton(
          icon: Icon(
            Icons.edit,
            color: maroon,
          ),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiscussionAddPost.toEdit(
                    user: widget.user,
                    index: widget.index,
                    ttl: dis.discussions[widget.index].data.title,
                    des: dis.discussions[widget.index].data.description,
                  ),
                ),
              );
            });
          },
        ),
      );
    }
    return widgets;
  }

  Widget _bottomDetails(DiscussionList dis) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
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
                      dis.discussions[widget.index].doesExist(widget.user.key)
                          ? "Unlike"
                          : "Like",
                      style: subHeader01(maroon),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      dis.upvoteData(widget.index, widget.user.key);
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
                  dis.discussions[widget.index].data.popularity.toString(),
                  style: subHeader01(maroon),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.comment,
                  color: maroon,
                  size: 20,
                ),
                SizedBox(width: 5.0),
                Text(
                  dis.discussions[widget.index].comments.length != null
                      ? dis.discussions[widget.index].comments.length.toString()
                      : "0",
                  style: subHeader01(maroon),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _commentDivider() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Divider(
            color: maroon,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            "COMMENTS",
            style: subHeader01(maroon),
          ),
        ),
        Expanded(
          flex: 1,
          child: Divider(
            color: maroon,
          ),
        ),
      ],
    );
  }

  Widget _addComment(DiscussionList dis) {
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TextField(
              maxLines: null,
              style: bodyText(maroon),
              controller: widget.addCom,
              decoration: InputDecoration(
                hintText: "What do you think about it?",
                hintStyle: TextStyle(
                  fontFamily: "Helvetica-Oblique",
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 25, bottom: 10),
            child: OutlinedButton(
              child: Text(
                'Submit',
                style: subHeader01(maroon),
              ),
              onPressed: () {
                dis.addComment(
                  description: widget.addCom.text,
                  disIndex: widget.index,
                  key: widget.user.key,
                  authorName: widget.user.name,
                );
                widget.addCom.clear();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: maroon),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _comments(BuildContext context, DiscussionList discussion) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: discussion.discussions[widget.index].comments.length ?? 0,
      itemBuilder: (context, index) {
        return DiscussionComWidget(
          user: widget.user,
          dataIndex: widget.index,
          comIndex: index,
        );
      },
    );
  }
}
