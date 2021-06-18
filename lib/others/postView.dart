/*import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/postDatabase.dart';
import 'postEdit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'post.dart';
import 'dart:async';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';
import 'pnnHomePage.dart';

class ViewPostNew extends StatefulWidget {
  final User user;
  final Post post;
  ViewPostNew(this.user, this.post);

  @override
  _ViewPostNewState createState() => _ViewPostNewState();
}

class _ViewPostNewState extends State<ViewPostNew> {
  List<Post> posts = [];
  User cuser;
  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    cuser = auth.currentUser;
    super.initState();
  }

  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  void newPosts(
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
    var post = new Post(nickname, author, body, comments, date, edit, keywords,
        title, likenum, flagnum);
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
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
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Discussion Board",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Helvetica',
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            backgroundColor: yellow,
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          // key: _formKey,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    widget.post.title,
                    style: TextStyle(
                      fontSize: 22,
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
                    'Author: ',
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
              //Steps Row
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    widget.post.author,
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
              //Steps Row
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    widget.post.date,
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
            if (widget.post.edit == true)
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
                // Padding(
                //padding: EdgeInsets.only(top: 20, left: 20),
                Container(
                  child: Flexible(
                    child: Text(
                      widget.post.body,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Helvetica',
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                //),
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
            ),
            /*if (widget.comments != null)/
              ..._getSteps(widget.contact["comments"]),*/
            Row(
              children: <Widget>[
                Container(
                  child: Text(widget.post.usersLiked.length.toString(),
                      style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                ),
                IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () =>
                        this.like(() => widget.post.likePost(cuser)),
                    color: widget.post.usersLiked.contains(cuser.uid)
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
                  child: Text(widget.post.usersFlagged.length.toString(),
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
                      this.like(() => widget.post.flagPost(cuser));
                      print(widget.post.flagnum);
                      if (widget.post.usersFlagged.contains(cuser.uid)) {
                        final snackBar =
                            SnackBar(content: Text('Post already reported.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (widget.post.flagnum >= 3) {
                        this.sendflag();
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
            ),
            if (widget.post.author == cuser.email ||
                cuser.email == "uphowtosofc@gmail.com")
              ..._ownerbuttons(
                  widget.post.body, widget.post.author, widget.post.date),
            //CommentHomePage(widget.user)
          ],
        ),
      ),
    );
  }

  List<Widget> _ownerbuttons(String body, String author, String date) {
    List<Widget> buttons = [];
    buttons.add(Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Padding(
          padding: EdgeInsets.only(top: 20, right: 20),
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(green),
              backgroundColor: MaterialStateProperty.all<Color>(green),
            ),
            onPressed: () {
              FirebaseDatabase.instance
                  .reference()
                  .child('posts')
                  .orderByChild('body')
                  .equalTo(body)
                  .once()
                  .then((DataSnapshot snapshot) {
                Map<String, dynamic> children = snapshot.value;
                children.forEach((key, value) {
                  FirebaseDatabase.instance
                      .reference()
                      .child('posts')
                      .child(key)
                      .remove();
                });
              });
              final snackBar = SnackBar(content: Text('Post deleted'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Navigator.of(context).pushNamed('/post'); //);
            },
            child: Text(
              'Delete Post',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ))
    ]));
    /*
    buttons.add(Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Padding(
          padding: EdgeInsets.only(top: 20, right: 20),
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(green),
              backgroundColor: MaterialStateProperty.all<Color>(green),
            ),
            onPressed: () {
              FirebaseDatabase.instance
                  .reference()
                  .child('posts')
                  .orderByChild('body')
                  .equalTo(body)
                  .once()
                  .then((DataSnapshot snapshot) {
                Map<String, dynamic> children = snapshot.value;
                children.forEach((key, value) {
                  FirebaseDatabase.instance
                      .reference()
                      .child('posts')
                      .child(key)
                      .remove();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditPosts(
                                cuser,
                              )));
                });
              });
              final snackBar = SnackBar(content: Text('Post edited'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text(
              'Edit Post',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ))
    ]));*/
    return buttons;
  }

  Future<void> sendflag() async {
    String username = 'uphowtosreport@gmail.com';
    String password = 'Uphowtos1.';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Automated Flagged Post Sender [UP How Tos]')
      ..recipients.add('uphowtosofc@gmail.com')
      ..subject = 'Post Reported Too Many Times'
      ..text =
          "This post has been reported too many times. Please inspect the said post. Details of the post below.\nTitle: " +
              widget.post.title +
              "\nBody: " +
              widget.post.body +
              "\nAuthor: " +
              widget.post.author +
              "\nDate: " +
              widget.post.date;
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
}
*/