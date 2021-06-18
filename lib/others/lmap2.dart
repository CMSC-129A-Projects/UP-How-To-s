/*import 'package:firebase_auth/firebase_auth.dart';
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

  Query _ref;
  DatabaseReference reference;
  void newComment(String nickname, String author, String body, String date,
      bool edit, int likenum, int flagnum) {
    var comment = new Comment(nickname, author, body, date, edit, 0, 0);
    comment.setId(saveComment(widget.contactKey, comment));
    this.setState(() {
      comments.add(comment);
    });
  }

  void updateComments() {
    getAllComments().then((comments) => {
          this.setState(() {
            this.comments = comments;
          })
        });
  }

  User cuser;
  Post post;
  String nickname;
  String author;
  String date;
  bool edit;
  String body;
  int flagnum;
  int likenum;
  Comment newc;
  String cdate;

  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  Future<void> sendflagcomment() async {
    String username = 'uphowtosreport@gmail.com';
    String password = 'Uphowtos1.';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from =
          Address(username, 'Automated Flagged Comment Sender [UP How Tos]')
      ..recipients.add('uphowtosofc@gmail.com')
      ..subject = 'Comment Reported Too Many Times'
      ..text =
          "This comment has been reported too many times. Please inspect the said comment. Details of the comment below.\nTitle: " +
              "\nBody: " +
              body +
              "\nAuthor: " +
              author +
              "\nDate: " +
              date;
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

  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance
        .reference()
        .child('posts')
        .child(widget.contactKey)
        .child('comments/')
        .orderByChild('date');
    reference = FirebaseDatabase.instance.reference().child('posts');
  }

  Widget _buildContactItem(Comment comment, {Map contact}) {
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
        /*if (comment.edit == true)
          Row(
            //Download Forms Text
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  '(edited)',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    color: yellow,
                  ),
                ),
              ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                comment.date,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          //Steps Row
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Like ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  color: yellow,
                ),
              ),
            ),
          ],
        ),*/
        /*Row(
          children: <Widget>[
            Container(
              child: Text(comment.usersLiked.length.toString(),
                  style: TextStyle(fontSize: 20)),
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            ),
            IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () => this.like(() => comment.likeComment(cuser)),
                color: comment.usersLiked.contains(cuser.uid)
                    ? Colors.green
                    : Colors.black)
          ],
        ),
        Row(
          //Steps Row
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Reports: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  color: yellow,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              child: Text(comment.usersFlagged.length.toString(),
                  style: TextStyle(fontSize: 20)),
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            ),
          ],
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
                  this.like(() => comment.flagComment(cuser));
                  if (comment.usersFlagged.contains(cuser.uid)) {
                    final snackBar =
                        SnackBar(content: Text('Post already reported.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (comment.flagnum >= 3) {
                    this.sendflagcomment();
                  }
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
        ),*/
        Expanded(
          flex: 8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contact['author'],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Helvetica-Bold',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
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
                              widget.contactKey, widget.contactKey)));
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

  _showDeleteDialog({Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete comment'),
            content: Text('Are you sure you want to delete this comment?'),
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
                  tooltip: 'Add comment',
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
              ),
            ),
            backgroundColor: maroon,
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

            return _buildContactItem(this.comments[index], contact: contact);
          },
        ),
      ),
    );
  }
}

/*

/*

    Query _ref = FirebaseDatabase.instance
        .reference()
        .child('posts')
        .orderByChild("title")
        .equalTo(searchTerm);
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map contact = snapshot.value;
          contact['key'] = snapshot.key;
          //return _buildContactItem(context,contact: contact);
          String small = contact["title"].toLowerCase();
          String smaller = searchTerm.toLowerCase();
          if (small.contains(smaller)) {
            return _buildContactItem(this.posts[index], context,
                contact: contact);
          } else
            return _buildEmpty();
        },
      ),
    );
  }
}
*/
class TextInputWidget extends StatefulWidget {
  final Function(String, String, String, List<Comment>, String, bool, String,
      String, int, int) callback;

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
    widget.callback(nickname, author, body, comments, date, edit, keywords,
        title, likenum, flagnum);
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
*/*/