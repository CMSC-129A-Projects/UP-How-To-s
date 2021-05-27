import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'postDatabase.dart';
import 'postAdd.dart';
import 'postList.dart';
import 'comments.dart';

class PostHomePage extends StatefulWidget {
  final User user;
  PostHomePage(this.user);
  @override
  _PostHomePageState createState() => _PostHomePageState();
}

class _PostHomePageState extends State<PostHomePage> {
  User user;
  List<Post> posts = [];
  void newPosts(String author, String body, List<Comment> comments, String date,
      bool edit, List<String> keywords, String title) {
    var post = new Post(author, body, comments, date, edit, keywords, title);
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
    return PostsInputWidget(this.newPosts, this.user);
  }
}

class PostsListPage extends StatefulWidget {
  final User user;
  PostsListPage(this.user);
  @override
  _PostsListPageState createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  User user;
  List<Post> posts = [];

  void newPosts(
    String author,
    String body,
    List<Comment> comments,
    String date,
    bool edit,
    List<String> keywords,
    String title,
  ) {
    var post = new Post(author, body, comments, date, edit, keywords, title);
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
        appBar: AppBar(title: Text('Discussion Board')),
        body: Column(children: <Widget>[
          Expanded(child: PostList()),
        ]));
  }
}
