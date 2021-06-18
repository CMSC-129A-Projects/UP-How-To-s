import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'post.dart';
import 'dart:async';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'postAdd.dart';
import 'postDatabase.dart';
import 'pnComments.dart';
import 'package:uphowtos1/colors_fonts.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class ViewPostNew extends StatefulWidget {
  final String contactKey;
  final Post post;
  final Map contact;
  ViewPostNew(this.post, this.contact, {this.contactKey});

  @override
  _ViewPostNewState createState() => _ViewPostNewState();
}

class _ViewPostNewState extends State<ViewPostNew> {
  List<Comment> comments = [];
  List<Comment> newcomments = [];
  /*
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
  }*/

  User cuser;
  Post post;
  TextEditingController newcomment = TextEditingController();
  String nickname;
  String author;
  String date;
  bool edit;
  String body;
  String keywords;
  String title;
  int flagnum;
  int likenum;
  DatabaseReference _ref;
  Comment newc;
  String cdate;

  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
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
              title +
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
    _ref = FirebaseDatabase.instance.reference().child('posts');
    newcomment = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;
    cuser = auth.currentUser;
    getPostsDetail();
    nickname = widget.contact['nickname'];
    title = widget.contact['title'];
    body = widget.contact['body'];
    keywords = widget.contact['keywords'];
    author = widget.contact['author'];
    date = widget.contact['date'];
    edit = widget.contact['edit'];
    author = widget.contact['author'];
    flagnum = widget.contact['flagnum'];
    likenum = widget.contact['likenum'];
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
                    "Post",
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _header(),
              _details(),
              _bottomDetails(),
              if (edit == true)
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
                        foregroundColor:
                            MaterialStateProperty.all<Color>(green),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(green),
                      ),
                      onPressed: () {
                        this.like(() => widget.post.flagPost(cuser));
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
              _commentDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20, right: 20),
                      child: IconButton(
                          icon: Icon(Icons.arrow_right_outlined),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentsList(
                                        widget.contactKey, cuser)));
                          },
                          color: widget.post.usersLiked.contains(cuser.uid)
                              ? Colors.green
                              : Colors.black)),
                ],
              ),
            ],
          ),
        ));
  }

  getPostsDetail() async {
    DataSnapshot snapshot =
        await _ref.child(widget.contactKey).child('comments/').once();
    Map contact = snapshot.value;
    newcomments = contact['comments'];
  }

  Widget _header() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              child: Text("JE"),
              backgroundColor: Colors.grey.shade400,
              foregroundColor: Colors.white,
              radius: 35.0,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Expanded(
                    child: Text(
                      nickname,
                      style: subHeader01(maroon),
                      maxLines: null,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: subHeader02(maroon),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _details() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            title,
            style: header01(maroon),
          ),
          SizedBox(height: 10),
          Text(
            body,
            style: bodyText(maroon),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _bottomDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      widget.post.usersLiked.contains(cuser.uid)
                          ? "Unlike"
                          : "Like",
                      style: subHeader01(maroon),
                    ),
                  ),
                  onPressed: () => this.like(() => widget.post.likePost(cuser)),
                  /* color: widget.post.usersLiked.contains(cuser.uid)
                          ? Colors.green
                          : Colors.black)*/
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text(widget.post.usersLiked.length.toString(),
                    style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => this.like(() => widget.post.likePost(cuser)),
                  color: widget.post.usersLiked.contains(cuser.uid)
                      ? Colors.green
                      : Colors.black)
            ],
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.thumb_up,
                  color: maroon,
                  size: 20,
                ),
                SizedBox(width: 5.0),
                Text(
                  likenum.toString(),
                  style: subHeader01(maroon),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.comment,
                  color: maroon,
                  size: 20,
                ),
                SizedBox(width: 5.0),
                Text(
                  comments.length != null ? comments.length.toString() : "0",
                  style: subHeader01(maroon),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _commentDivider() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Divider(
            color: maroon,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            "COMMENTS",
            style: subHeader01(maroon),
          ),
        ),
        Expanded(
          flex: 1,
          child: Divider(
            color: maroon,
          ),
        ),
      ],
    );
  }
}
