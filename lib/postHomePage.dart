import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/postDatabase.dart';
import 'post.dart';
import 'postList.dart';
import 'postTextInputWidget.dart';
import 'comments.dart';

class MyHomePage extends StatefulWidget {
  final User user;

  MyHomePage(this.user);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  List<Comment> d = [];
  bool s;
  List<String> sss = [];
  void newPost(String text) {
    var post = new Post(text, widget.user.displayName, d, "d", s, sss, "d");
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
      appBar: AppBar(title: Text('Please use UPmail!')),
      body: Column(
        children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user)),
          TextInputWidget(this.newPost)
        ],
      ),
    );
  }
}
