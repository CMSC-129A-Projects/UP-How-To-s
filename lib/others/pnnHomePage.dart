/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'postDatabase.dart';
import 'post.dart';

import 'package:intl/intl.dart';

class CommentHomePage extends StatefulWidget {
  final User user;

  CommentHomePage(this.user);

  @override
  _CommentHomePageState createState() => _CommentHomePageState();
}

class _CommentHomePageState extends State<CommentHomePage> {

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CommentTextInput(this.newComment),
     
    ]);
  }

  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

}

class CommentTextInput extends StatefulWidget {
  final Function(String, String, String, String, bool, int, int) callback;

  CommentTextInput(this.callback);

  @override
  _CommentTextInputState createState() => _CommentTextInputState();
}

class _CommentTextInputState extends State<CommentTextInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    widget.callback(
        cuser.displayName, cuser.email, controller.text, date, false, 0, 0);
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  User cuser;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    cuser = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          controller: this.controller,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.message),
              labelText: "Type a message:",
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                splashColor: Colors.blue,
                tooltip: "Post message",
                onPressed: this.click,
              ))),
    );
  }
}*/
