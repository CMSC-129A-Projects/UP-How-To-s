import 'package:flutter/material.dart';
import 'package:uphowtos1/disBlockData.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disData.dart';
import 'package:uphowtos1/disList.dart';
import 'package:uphowtos1/pseudoUser.dart';
import 'package:uphowtos1/copy.dart';
import 'package:uphowtos1/projTextStyles.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

// ignore: must_be_immutable
class DiscussionAddPost extends StatelessWidget {
  final User user;
  TextEditingController title = TextEditingController();
  TextEditingController dscrp = TextEditingController();
  DiscussionAddPost(this.user);

  String ttl;
  String des;
  int index;

  DiscussionAddPost.toEdit({this.user, this.ttl, this.des, this.index});

  @override
  Widget build(BuildContext context) {
    final dis = context.watch<DiscussionList>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: maroon),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          ttl == null ? "Add Post" : "Edit Post",
          style: subHeader01(maroon),
        ),
      ),
      body: SingleChildScrollView(child: _body(context, dis)),
    );
  }

  Widget _body(BuildContext context, DiscussionList dis) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _header(),
          _titleInput(),
          _descriptionInput(),
          _submitButton(context, dis),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context, DiscussionList dis) {
    return OutlinedButton(
      child: Text(
        "UPDATE",
        style: subHeader01(maroon),
      ),
      onPressed: () {
        print(user.key);
        if (title.text.length > 0 && dscrp.text.length > 0 && ttl == null) {
          DiscussionData d = new DiscussionData(
            authorName: user.name,
            title: title.text,
            description: dscrp.text,
            author: user.key,
          );
          dis.addDiscussion(DiscussionBlock(d));
        } else {
          print("EDIT ENTERED");
          dis.update(title.text, dscrp.text, index);
        }
        Navigator.pop(context);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: maroon),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }

  TextField _descriptionInput() {
    return TextField(
      controller: dscrp..text = des,
      style: bodyText(maroon),
      maxLines: null,
      decoration: InputDecoration(
        hintText: "What is it about?",
        hintStyle: TextStyle(
          fontFamily: "Helvetica-Oblique",
        ),
        border: InputBorder.none,
      ),
    );
  }

  TextField _titleInput() {
    return TextField(
      controller: title..text = ttl,
      style: header01(maroon),
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(
          fontFamily: "Helvetica-Oblique",
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget _header() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                child: Text("JE"),
                backgroundColor: Colors.grey.shade400,
                foregroundColor: Colors.white,
                radius: 35.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: subHeader01(maroon),
                    maxLines: null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    DateTime.now().toString(),
                    style: subHeader02(maroon),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
