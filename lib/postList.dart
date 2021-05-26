/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'post.dart';

class PostList extends StatefulWidget {
  /*final List<Post> listItems;
  final User user;
*/
  PostList();

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/postHomePage.dart';
import 'comments.dart';
import 'postDatabase.dart';
import 'postEdit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'post.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class PostList extends StatefulWidget {
  PostList();
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  User user;
  Query _ref;
  List<Post> posts = [];
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('posts');

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('posts')
        .orderByChild('title');
  }

  Widget _buildContactItem({Map contact}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 6, offset: Offset(0, 4)),
          ]),
      child: Row(children: <Widget>[
        Expanded(
          flex: 8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contact['title'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  contact['date'],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Helvetica',
                    color: Colors.grey[850],
                  ),
                ),
                SizedBox(height: 2.0),
              ]),
        ),
        Expanded(
          flex: 1,
          child: PopupMenuButton<int>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            onSelected: (item) {
              switch (item) {
                case 0:
                  //Edit Item
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditPosts(
                                newPosts,
                                user,
                                contactKey: contact['key'],
                              )));
                  break;
                case 1:
                  //Remove Item
                  _showDeleteDialog(contact: contact);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Edit'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text('Remove'),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void newPosts(String author, String body, List<Comment> comments, String date,
      bool edit, List<String> keywords, String title) {
    var post = new Post(author, body, comments, date, edit, keywords, title);
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
    });
  }

  _showDeleteDialog({Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Delete this post? All the comments in the posts will also be deleted'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                style: ElevatedButton.styleFrom(primary: green),
              ),
              ElevatedButton(
                onPressed: () {
                  reference
                      .child(contact['key'])
                      .remove()
                      .whenComplete(() => Navigator.pop(context));
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(primary: green),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: DrawerDetails(),
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
                            builder: (context) => PostHomePage(user)));
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
            backgroundColor: green,
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.only(top: 6.0),
        width: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;
            return _buildContactItem(contact: contact);
          },
        ),
      ),
    );
  }
}
