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

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/postDatabase.dart';
import 'post.dart';
import 'postList.dart';
import 'postTextInputWidget.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseUser user;

  MyHomePage(this.user);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    var post = new Post(text, widget.user.displayName);
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
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user)),
          TextInputWidget(this.newPost)
        ]));
  }
}
*/

class PostsListPage extends StatefulWidget {
  final User user;
  PostsListPage(this.user);
  @override
  _PostsListPageState createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  User user;
  List<Post> posts = [];

  void newPosts(String title, List<Comment> comments, List<String> keywords,
      String body, String date, bool edit, String author) {
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
