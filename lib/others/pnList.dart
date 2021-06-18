/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'postView.dart';
import 'package:firebase_database/firebase_database.dart';

final maroon = const Color(0xFF8A1538); // UP yellow
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class NewPostList extends StatefulWidget {
  final List<Post> listItems;
  final User user;

  NewPostList(this.listItems, this.user);

  @override
  _NewPostListState createState() => _NewPostListState();
}

class _NewPostListState extends State<NewPostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text(post.body),
            subtitle: Text(post.author),
          )),
          Row(
            children: <Widget>[
              Container(
                child: Text(post.usersLiked.length.toString(),
                    style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => this.like(() => post.likePost(widget.user)),
                  color: post.usersLiked.contains(widget.user.uid)
                      ? Colors.green
                      : Colors.black)
            ],
          )
        ]));
      },
    );
  }
}
*/