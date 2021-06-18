/*import 'package:flutter/material.dart';
import 'package:uphowtos1/postView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postView.dart';

final maroon = const Color(0xFF8A1538); // UP yellow
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class PostList extends StatefulWidget {
  final List<Post> listItems;
  final User user;
  PostList(this.listItems, this.user);
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('posts');

  final FirebaseAuth auth = FirebaseAuth.instance;
  User cuser;
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  Future<void> _getData() async {
    setState(() {
      DatabaseReference reference =
          FirebaseDatabase.instance.reference().child('posts');
    });
  }

  @override
  void initState() {
    super.initState();
    cuser = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
            itemCount: this.widget.listItems.length,
            itemBuilder: (context, index) {
              var post = this.widget.listItems[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ViewPostNew(
                                this.cuser,
                                post,
                              )));
                },
                child: Card(
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
                          onPressed: () =>
                              this.like(() => post.likePost(cuser)),
                          color: post.usersLiked.contains(cuser.uid)
                              ? Colors.green
                              : Colors.black)
                    ],
                  ),
                ])),
              );
            }),
        onRefresh: _getData);
  }
}
*/