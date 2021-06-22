import 'package:flutter/material.dart';
import 'post.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'pComments.dart';
import 'package:uphowtos1/colors_fonts.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

class ViewPostNew extends StatefulWidget {
  final String contactKey;
  final Post post;
  final Map contact;
  ViewPostNew(this.post, this.contact, {this.contactKey});

  @override
  _ViewPostNewState createState() => _ViewPostNewState();
}

class _ViewPostNewState extends State<ViewPostNew> {
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
  Comment newc;
  String cdate;

  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  // Future<void> sendflag() async {
  //   final Email email = Email(
  //     body:
  //         "This comment has been reported. Please inspect the said post. Details of the comment below.\nAuthor: " +
  //             author +
  //             "\nNickname: " +
  //             nickname +
  //             "\nDate: " +
  //             date +
  //             "\nBody: " +
  //             body,
  //     subject: 'flag',
  //     recipients: ['uphowtosofc@gmail.com'],
  //     isHTML: false,
  //   );

  //   String platformResponse;

  //   try {
  //     await FlutterEmailSender.send(email);
  //     platformResponse = 'success';
  //   } catch (error) {
  //     platformResponse = error.toString();
  //   }
  //   print(platformResponse);
  // }

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
    newcomment = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;
    cuser = auth.currentUser;
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
                          color: spotblack,
                        ),
                      ),
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
                            MaterialStateProperty.all<Color>(maroon),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(maroon),
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
            ],
          ),
        ));
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
            child: Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5),
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/avatar.png'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Text(
                    nickname,
                    style: header02(maroon),
                    maxLines: null,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.thumb_up),
                    onPressed: () =>
                        this.like(() => widget.post.likePost(cuser)),
                    color: widget.post.usersLiked.contains(cuser.uid)
                        ? maroon
                        : Colors.black),
                SizedBox(width: 5.0),
                Text(
                  widget.post.usersLiked.length.toString(),
                  style: subHeader01(maroon),
                ),
                SizedBox(width: 10.0),
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
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(green),
              backgroundColor: MaterialStateProperty.all<Color>(green),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CommentsList(widget.contactKey, cuser)));
            },
            child: Text(
              'SEE COMMENTS',
              style: subHeader01(Colors.white),
            ),
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
