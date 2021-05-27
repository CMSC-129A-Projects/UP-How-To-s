import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:uphowtos1/comments.dart';
import 'package:intl/intl.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class StepsTextFields extends StatefulWidget {
  final int index;
  StepsTextFields(this.index);

  @override
  _StepsTextFieldsState createState() => _StepsTextFieldsState();
}

class _StepsTextFieldsState extends State<StepsTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _EditPostsState.stepsList[widget.index] ?? '';
    });
    return TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (v) => _EditPostsState.stepsList[widget.index] = v,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          border: OutlineInputBorder(),
          hintText: 'Step n',
        ),
        validator: (v) {
          if (v.trim().isEmpty) return 'Please enter step here';
          return null;
        });
  }
}

class EditPosts extends StatefulWidget {
  final String contactKey; //this is edited to have final -Marc
  final Function(
          String, String, List<Comment>, String, bool, List<String>, String)
      callback;
  final User user;
  EditPosts(this.callback, this.user, {this.contactKey});

  @override
  _EditPostsState createState() => _EditPostsState();
}

class _EditPostsState extends State<EditPosts> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  List<dynamic> word = [null];
  static List<String> stepsList;
  List<Comment> comments;
  //this is where the list of steps is placed, manipulate this para masulod/makakuha from the database

  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    stepsList = [null];
    _ref = FirebaseDatabase.instance.reference().child('posts');
    title = TextEditingController();
    body = TextEditingController();
    _nameController = TextEditingController();
    getPostsDetail();
    setState(() {});
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
          key: _formKey,
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
            ..._getSteps(),
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
      ),
    );
  }

  List<Widget> _getSteps() {
    List<Widget> stepsTextFields = [];
    for (int i = 1; i < stepsList.length; i++) {
      stepsTextFields.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: Container(child: StepsTextFields(i)),
              ),
              SizedBox(
                width: 10,
              ),
              _addRemoveButton(i == stepsList.length - 1, i),
            ],
          ),
        ),
      );
    }
    return stepsTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          stepsList.add(null);
        } else
          stepsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  getPostsDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();
    Map contact = snapshot.value;
    title.text = contact['title'];
    body.text = contact['body'];
    comments = contact['comments'];

    word = contact['keywords'];
    for (int i = 0; i < word.length; i++) {
      if (word[i] != '') {
        stepsList.add(word[i]);
        setState(() {});
      }
    }
    //_getSteps();
  }

  void click() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    String name = user.displayName;
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    print(name +
        "dddddddddddd-----------------------------------------------------------------------------------------------------------------------------------------------------------" +
        date);
    if (name != null)
      widget.callback(
        name,
        body.text,
        comments,
        date,
        true,
        stepsList,
        title.text,
      );
    FocusScope.of(context).unfocus();
    title.clear();
    _nameController.clear();
    body.clear();
    _ref.child(widget.contactKey).remove();
    Navigator.of(context).pushNamed('/post');
    final snackBar = SnackBar(content: Text('Post edited'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
