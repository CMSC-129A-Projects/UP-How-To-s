import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';
import 'package:uphowtos1/pseudoUser.dart';
import 'package:uphowtos1/copy.dart';
import 'package:uphowtos1/projTextStyles.dart';
import 'package:uphowtos1/disNewPost.dart';

class DiscussionComWidget extends StatefulWidget {
  final int dataIndex;
  final int comIndex;
  final User user;

  DiscussionComWidget(
      {@required this.dataIndex, @required this.comIndex, @required this.user});

  @override
  _DiscussionComWidgetState createState() => _DiscussionComWidgetState();
}

class _DiscussionComWidgetState extends State<DiscussionComWidget> {
  @override
  Widget build(BuildContext context) {
    DiscussionList dis = context.watch<DiscussionList>();

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
        ],
      ),
    );
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
      ],
    );
  }

  Widget _comDetails(DiscussionList dis) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: Text(
        dis.discussions[widget.dataIndex].comments[widget.comIndex].description,
        textAlign: TextAlign.left,
        style: bodyText(maroon),
      ),
    );
  }
}
