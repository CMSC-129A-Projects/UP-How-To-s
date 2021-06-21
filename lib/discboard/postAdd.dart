import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'post.dart';
import 'package:uphowtos1/colors_fonts.dart';

// ignore: must_be_immutable
class PostsInputWidget extends StatefulWidget {
  Function(String, String, String, String, bool, String, String, int, int)
      callback;
  Map contact;
  PostsInputWidget(this.callback);
  PostsInputWidget.toEdit(this.contact);
  @override
  _PostInputWidgetState createState() => _PostInputWidgetState();
}

class _PostInputWidgetState extends State<PostsInputWidget> {
  final title = TextEditingController();
  final body = TextEditingController();
  final tags = TextEditingController();
  DatabaseReference _ref;

  String editTitle = "";
  String editDesc = "";
  String editKeywords = "";
  

  @override
  void initState() {
    if(widget.contact != null){
      _ref = FirebaseDatabase.instance.reference().child('posts');
      editTitle = widget.contact['title'];
      editDesc = widget.contact['body'];
      editKeywords = widget.contact['keywords'];
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    body.dispose();
    tags.dispose();
  }

  void click() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    bool flag = false;
    String name = user.email;
    String nickname = user.displayName;
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

    if (title.text == '' || body.text == '' || flag == true) {
      final snackBar = SnackBar(
          content: Text('Please fill empty fields or remove empty steps'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      widget.callback(
          nickname, name, body.text, date, false, tags.text, title.text, 0, 0);
      FocusScope.of(context).unfocus();
      Navigator.of(context).pushNamed('/post');
      final snackBar = SnackBar(content: Text('Post added'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
    _ref.child(widget.contact['key']).update(contact).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  // SingleChildScrollView _body01() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       key: _formKey,
  //       children: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 20),
  //               child: Text(
  //                 'Post Title:',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontFamily: 'Helvetica',
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Padding(
  //                 padding: EdgeInsets.only(top: 20, left: 20, right: 20),
  //                 child: Container(
  //                   child: TextFormField(
  //                       controller: this.title,
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: null,
  //                       decoration: InputDecoration(
  //                         labelText: "Sample: Where is TBA?",
  //                         fillColor: Colors.white,
  //                         focusedBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           borderSide: BorderSide(
  //                             color: spotblack,
  //                           ),
  //                         ),
  //                         enabledBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8.0),
  //                           borderSide: BorderSide(
  //                             color: green,
  //                             width: 2.0,
  //                           ),
  //                         ),
  //                       ),
  //                       validator: (v) {
  //                         if (v.trim().isEmpty)
  //                           return 'Please enter post title here';
  //                         return null;
  //                       }),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 20),
  //               child: Text(
  //                 'Post Body:',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontFamily: 'Helvetica',
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Padding(
  //                 padding: EdgeInsets.only(top: 20, left: 20, right: 20),
  //                 child: Container(
  //                   child: TextFormField(
  //                       controller: this.body,
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: null,
  //                       decoration: InputDecoration(
  //                         labelText:
  //                             "Sample: Hi. I'm a freshie and idk where TBA is. I have most of my classes there, can anyone please tell me, my classmates dont know where it is too.",
  //                         fillColor: Colors.grey,
  //                         focusedBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           borderSide: BorderSide(
  //                             color: spotblack,
  //                           ),
  //                         ),
  //                         enabledBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8.0),
  //                           borderSide: BorderSide(
  //                             color: green,
  //                             width: 2.0,
  //                           ),
  //                         ),
  //                       ),
  //                       validator: (v) {
  //                         if (v.trim().isEmpty)
  //                           return 'Please enter post content here';
  //                         return null;
  //                       }),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 20),
  //               child: Text(
  //                 'Keywords/Tags: ',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontFamily: 'Helvetica',
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 20),
  //               child: Text(
  //                 'Please put all keywords \nand separate them with commas.',
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                   fontFamily: 'Helvetica',
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Padding(
  //                 padding: EdgeInsets.only(top: 20, left: 20, right: 20),
  //                 child: Container(
  //                   child: TextFormField(
  //                       controller: this.tags,
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: null,
  //                       decoration: InputDecoration(
  //                         labelText: "Sample: TBA, freshie, location ",
  //                         fillColor: Colors.grey,
  //                         focusedBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           borderSide: BorderSide(
  //                             color: spotblack,
  //                           ),
  //                         ),
  //                         enabledBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8.0),
  //                           borderSide: BorderSide(
  //                             color: green,
  //                             width: 2.0,
  //                           ),
  //                         ),
  //                       ),
  //                       validator: (v) {
  //                         if (v.trim().isEmpty)
  //                           return 'Please enter post content here';
  //                         return null;
  //                       }),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           //Submit Button
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, right: 20),
  //               child: TextButton(
  //                 style: ButtonStyle(
  //                   foregroundColor: MaterialStateProperty.all<Color>(green),
  //                   backgroundColor: MaterialStateProperty.all<Color>(green),
  //                 ),
  //                 onPressed: () {
  //                   this.click();
  //                 },
  //                 child: Text(
  //                   'Post',
  //                   style: TextStyle(
  //                     fontFamily: 'Helvetica',
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  AppBar _appBar() {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.editTitle.length == 0 ? "Add Post" : "Edit Post",
            style: pageTitle(green),
          ),
          Text(
            'Administrator Mode',
            style: pageSubTitle(green),
          ),
        ],
      ),
    );
  }

  Widget _body() {
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
          _keywordInput(),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _keywordInput(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Divider(),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "TAGS",
                style: subHeader01(Colors.grey[850]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Divider(),
            ),
          ],
        ),
        SizedBox(height:5),
        TextFormField(
          controller: tags..text = editKeywords,
          style: subHeader01(green),
          maxLines: null,
          decoration: InputDecoration(
            hintText: "Ex: Forms, Holidays, Orgs",
            hintStyle: TextStyle(
              fontFamily: "Helvetica-Oblique",
            ),
            border: InputBorder.none,
          ),
          validator: (v) {
            if (v.trim().isEmpty)
              return 'Please enter keywords here';
            return null;
          }
        )
      ],
    );
  }

  Widget _submitButton() {
    return OutlinedButton(
      child: Text(
        "UPDATE",
        style: subHeader01(green),
      ),
      onPressed: () {
        if(editTitle.length == 0){
          this.click();
        }
        else{
          this.editPost();
        }
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: green),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }

  TextFormField _descriptionInput() {
    return TextFormField(
      controller: this.body..text = editDesc,
      style: bodyText(maroon),
      maxLines: null,
      decoration: InputDecoration(
        hintText: "What is it about?",
        hintStyle: TextStyle(
          fontFamily: "Helvetica-Oblique",
        ),
        border: InputBorder.none,
      ),
      validator: (v) {
        if (v.trim().isEmpty)
          return 'Please enter description here';
        return null;
      }
    );
  }

  TextFormField _titleInput() {
    return TextFormField(
      controller: title..text = editTitle,
      style: header01(maroon),
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(
          fontFamily: "Helvetica-Oblique",
        ),
        border: InputBorder.none,
      ),
      validator: (v) {
        if (v.trim().isEmpty)
          return 'Please enter title here';
        return null;
      }
    );
  }

  Widget _header() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    String nickname = user.displayName;
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
        top: 30,
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
                    nickname,
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

class CommentInputWidget extends StatefulWidget {
  final User user;
  final Function(String, String, String, String, bool, int, int) callback;
  CommentInputWidget(this.callback, this.user);

  @override
  _CommentInputWidgetState createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;

  final title = TextEditingController();
  final body = TextEditingController();
  final tags = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    body.dispose();
    tags.dispose();
    _nameController.dispose();
  }

  void click() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    String name = user.email;
    String nickname = user.displayName;
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

    if (body.text == '') {
      final snackBar = SnackBar(
          content: Text('Please fill empty fields or remove empty steps'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      widget.callback(nickname, name, body.text, date, false, 0, 0);
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
      final snackBar = SnackBar(content: Text('Comment added'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  "Create New Comment",
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
          key: _formKey,
          children: <Widget>[
            Row(
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
                            labelText: "Write commment here",
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
                      foregroundColor: MaterialStateProperty.all<Color>(green),
                      backgroundColor: MaterialStateProperty.all<Color>(green),
                    ),
                    onPressed: () {
                      this.click();
                    },
                    child: Text(
                      'Add comment',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
