import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'postDatabase.dart';
import 'post.dart';
import 'postAdd.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'pnCommentEdit.dart';
import 'dart:async';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblackf

class CommentsList extends StatefulWidget {
  final User user;
  final String contactKey;
  CommentsList(this.contactKey, this.user);

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  List<Comment> comments = [];
  void newComment(String nickname, String author, String body, String date,
      bool edit, int likenum, int flagnum) {
    var comment = new Comment(nickname, author, body, date, edit, 0, 0);
    comment.setId(saveComment(widget.contactKey, comment));
    this.setState(() {
      comments.add(comment);
    });
  }

  void updateComments() {
    getAllComments(widget.contactKey).then((comments) => {
          this.setState(() {
            this.comments = comments;
          })
        });
  }

  //FOR THE SEARCHTAB
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory;
  String selectedTerm;
  FloatingSearchBarController controller;

  //FOR DISPLAYING DATA
  DatabaseReference reference;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<String> filterSearchTerms({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState() {
    super.initState();
    updateComments();
    reference = FirebaseDatabase.instance
        .reference()
        .child('posts')
        .child(widget.contactKey)
        .child('comments');
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
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
                  "Comments",
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
                                CommentInputWidget(newComment, widget.user)));
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  splashRadius: 24.0,
                  tooltip: 'Add post',
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
      body: SearchResultListView(
        widget.contactKey,
        this.comments,
        searchTerm: selectedTerm,
      ),
    );
  }
}

class SearchResultListView extends StatelessWidget {
  final String searchTerm;
  final String contactKey;
  final List<Comment> comments;
  SearchResultListView(
    this.contactKey,
    this.comments, {
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  _showDeleteDialog(context, {Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['title']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                style: ElevatedButton.styleFrom(primary: maroon),
              ),
              ElevatedButton(
                onPressed: () {
                  DatabaseReference reference = FirebaseDatabase.instance
                      .reference()
                      .child('posts')
                      .child(this.contactKey)
                      .child('comments');
                  reference
                      .child(contact['key'])
                      .remove()
                      .whenComplete(() => Navigator.pop(context));
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(primary: maroon),
              )
            ],
          );
        });
  }

  Future<void> sendflag(
      String body, String author, String date, String nickname) async {
    String username = 'uphowtosreport@gmail.com';
    String password = 'Uphowtos1.';

    final smtpServer = gmailSaslXoauth2(username, password);
    final message = Message()
      ..from =
          Address(username, 'Automated Flagged Comment Sender [UP How Tos]')
      ..recipients.add('uphowtosofc@gmail.com')
      ..subject = 'Comment Reported Too Many Times'
      ..text =
          "This comment has been reported. Please inspect the said post. Details of the comment below.\nAuthor: " +
              author +
              "\nNickname: " +
              nickname +
              "\nDate: " +
              date +
              "\nBody: " +
              body;
    try {
      final sendReport = await send(message, smtpServer);
      print('Report sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Report not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Widget _buildContactItem(comment, context, {Map contact}) {
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
                  contact['body'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  contact['nickname'],
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
                          builder: (_) => EditComment(
                                this.contactKey,
                                contact['key'],
                              )));
                  break;
                case 1:
                  //Remove Item
                  _showDeleteDialog(context, contact: contact);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, right: 20),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(green),
                  backgroundColor: MaterialStateProperty.all<Color>(green),
                ),
                onPressed: () {
                  final snackBar =
                      SnackBar(content: Text('Post already reported.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  this.sendflag(contact['body'], contact['author'],
                      contact['date'], contact['nickname']);
                },
                child: Text(
                  'Report Post',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildEmpty() {
    return Container(
        //very important, makes us dodge errors hahahah
        ///FILLER BUILDER
        );
  }

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      Query _ref = FirebaseDatabase.instance
          .reference()
          .child('posts')
          .child(this.contactKey)
          .child('comments')
          .orderByChild('date');
      return Container(
        margin: EdgeInsets.only(top: 6.0),
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;

            return _buildContactItem(this.comments[index], context,
                contact: contact);
          },
        ),
      );
    }

    Query _ref = FirebaseDatabase.instance
        .reference()
        .child('posts')
        .child(this.contactKey)
        .child('comments')
        .orderByChild('date');
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map contact = snapshot.value;
          contact['key'] = snapshot.key;
          //return _buildContactItem(context,contact: contact);
          String small = contact["body"].toLowerCase();
          String smaller = searchTerm.toLowerCase();
          if (small.contains(smaller)) {
            return _buildContactItem(this.comments[index], context,
                contact: contact);
          } else
            return _buildEmpty();
        },
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  final Function(String, String, String, String, bool, String, String, int, int)
      callback;

  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  String nickname;
  User user;
  String author;
  String body;
  String date;
  bool edit;
  String title;
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
        nickname, author, body, date, edit, keywords, title, likenum, flagnum);
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
