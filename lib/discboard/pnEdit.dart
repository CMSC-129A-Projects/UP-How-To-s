import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class EditPosts extends StatefulWidget {
  final String contactKey;

  EditPosts({this.contactKey});

  @override
  _EditPostsState createState() => _EditPostsState();
}

class _EditPostsState extends State<EditPosts> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController tags = TextEditingController();
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('posts');
    title = TextEditingController();
    body = TextEditingController();
    tags = TextEditingController();
    getPostsDetail();
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
                    "Update Existing Post",
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
            //key: _formKey,
            children: <Widget>[
              Row(
                //Download Forms Text
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Post Title:',
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
                //Download Forms Textbox
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        child: TextFormField(
                            controller: this.title,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: "Sample: Where is TBA?",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: spotblack,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: green,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter post title here';
                              return null;
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //Download Forms Text
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Post Body:',
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
                //Download Forms Textbox
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        child: TextFormField(
                            controller: this.body,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText:
                                  "Sample: I'm a freshman and I still don't know where is TBA. A lot of my class addresses are TBA. Can anybody tell me where TBA is?",
                              fillColor: Colors.grey,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: spotblack,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: green,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter post content here';
                              return null;
                            }),
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
                      'Keywords/Tags: ',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Please put all keywords \nand separate them with commas.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Helvetica',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        child: TextFormField(
                            controller: this.tags,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: "Sample: TBA, freshie, location ",
                              fillColor: Colors.grey,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: spotblack,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: green,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter post content here';
                              return null;
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //Submit Button
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
                        this.editPost();
                      },
                      child: Text(
                        'Update Existing Post',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  getPostsDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();
    Map contact = snapshot.value;
    title.text = contact['title'];
    body.text = contact['body'];
    tags.text = contact['keywords'];
  }

  void editPost() {
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

    Map<String, dynamic> contact = {
      'title': title.text,
      'body': body.text,
      'keywords': tags.text,
      'edit': true,
      'date': date,
    };
    final snackBar = SnackBar(content: Text('Post edited'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _ref.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }
}
