/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'postDatabase.dart';
import 'postAdd.dart';
import 'postList.dart';

class PostHomePage extends StatefulWidget {
  final User user;

  PostHomePage(this.user);

  @override
  _PostHomePageState createState() => _PostHomePageState();
}

class _PostHomePageState extends State<PostHomePage> {
  List<Post> posts = [];
  void newPost(
      String nickname,
      String author,
      String body,
      List<Comment> comments,
      String date,
      bool edit,
      String keywords,
      String title,
      int likenum,
      int flagnum) {
    var post = new Post(
        nickname, author, body, comments, date, edit, keywords, title, 0, 0);
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
    });
  }

  void updatePosts() {
    getAllPosts().then((posts) => {
          this.setState(() {
            this.posts = posts;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 2.0),
                blurRadius: 4.0,
              )
            ]),
            child: AppBar(
              shadowColor: Colors.grey,
              elevation: 12.0,
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Discussion Board",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  Text(
                    'Administrator Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostsInputWidget(newPost, widget.user)));
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    splashRadius: 24.0,
                    tooltip: 'Add Staff',
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              backgroundColor: Colors.yellow,
            ),
          ),
          preferredSize: Size.fromHeight(60.0),
        ),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user)),
          //  TextInputWidget(this.newPost)
        ]));
  }
}

class TextInputWidget extends StatefulWidget {
  final Function(
          String, String, List<Comment>, String, bool, String, String, int, int)
      callback;

  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  User user;
  String author;
  String body;
  String date;
  bool edit;
  String title;
  List<Comment> comments;
  String keywords;
  String usersLiked;
  String usersFlagged;
  int likenum;
  int flagnum;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(
        author, body, comments, date, edit, keywords, title, likenum, flagnum);
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: "Type a message:",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue,
              tooltip: "Post message",
              onPressed: this.click,
            )));
  }
}
*/