import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'formsAList.dart';
import 'package:uphowtos1/mainDrawerDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'mainDrawerDetails.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

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
      _nameController.text = _EditFormsAState.stepsList[widget.index] ?? '';
    });

    return TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (v) => _EditFormsAState.stepsList[widget.index] = v,
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

class EditFormsA extends StatefulWidget {
  String contactKey;
  final Function(String, List<String>, String) callback;
  final FirebaseUser user;
  EditFormsA(this.callback, this.user, {this.contactKey});

  @override
  _EditFormsAState createState() => _EditFormsAState();
}

class _EditFormsAState extends State<EditFormsA> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> stepsList = [
    null
  ]; //this is where the list of steps is placed, manipulate this para masulod/makakuha from the database

  TextEditingController title = TextEditingController();
  TextEditingController url = TextEditingController();
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child('formsA');
    title = TextEditingController();
    url = TextEditingController();
    _nameController = TextEditingController();
    getFormsDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDetails(),
      appBar: AppBar(
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Edit Forms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Helvetica',
                ),
              ),
              Text(
                'Administrator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          backgroundColor: maroon,
          elevation: 4.0),
      body: SingleChildScrollView(
        child: Column(
          key: _formKey,
          children: <Widget>[
            Row(
              //Form Name
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: Text(
                    "Form Name:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: Container(
                      height: 30,
                      child: TextFormField(
                          controller: this.title,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 2),
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter step here';
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
                    'Steps: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ..._getSteps(),
            Row(
              //Download Forms Text
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Download Form Links Here: ',
                    style: TextStyle(
                      fontSize: 20,
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
                          controller: this.url,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            border: OutlineInputBorder(),
                            hintText: 'https...',
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter step here';
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
                      foregroundColor: MaterialStateProperty.all<Color>(maroon),
                      backgroundColor: MaterialStateProperty.all<Color>(maroon),
                    ),
                    onPressed: () {
                      this.click();
                      _ref
                          .child(widget.contactKey)
                          .remove()
                          .whenComplete(() => Navigator.pop(context));
                      final snackBar =
                          SnackBar(content: Text('Submitted, maybe'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      'Submit',
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
    for (int i = 0; i < stepsList.length; i++) {
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
          color: (add) ? Colors.green : maroon,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  getFormsDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();

    Map contact = snapshot.value;

    title.text = contact['title'];
    url.text = contact['url'];
  }

  void click() {
    widget.callback(title.text, stepsList, url.text);
    FocusScope.of(context).unfocus();
    title.clear();
    _nameController.clear();
    url.clear();
  }
}

/*import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'formsAList.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/mainDrawerDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'mainDrawerDetails.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class EditFormsA extends StatefulWidget {
  String contactKey;
  EditFormsA({this.contactKey});
  @override
  _EditFormsAState createState() => _EditFormsAState();
}

class _EditFormsAState extends State<EditFormsA> {
  TextEditingController _title, _url;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> stepsList = [
    null
  ]; //this is where the list of steps is placed, manipulate this para masulod/makakuha from the database

  DatabaseReference _ref;

  void click() {
    FocusScope.of(context).unfocus();
    _title.clear();
    _nameController.clear();
    _url.clear();
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _nameController = TextEditingController();
    _url = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('formsA');
    getFormsDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDetails(),
      appBar: AppBar(
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Add Forms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Helvetica',
                ),
              ),
              Text(
                'Administrator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          backgroundColor: maroon,
          elevation: 4.0),
      body: SingleChildScrollView(
        child: Column(
          key: _formKey,
          children: <Widget>[
            Row(
              //Form Name
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: Text(
                    "Form Name:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: Container(
                      height: 30,
                      child: TextFormField(
                          controller: _title,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 2),
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter step here';
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
                    'Steps: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ..._getSteps(),
            Row(
              //Download Forms Text
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Download Form Links Here: ',
                    style: TextStyle(
                      fontSize: 20,
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
                          controller: _url,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            border: OutlineInputBorder(),
                            hintText: 'https...',
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter step here';
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
                      foregroundColor: MaterialStateProperty.all<Color>(maroon),
                      backgroundColor: MaterialStateProperty.all<Color>(maroon),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      saveForms();
                      this.click();
                      final snackBar =
                          SnackBar(content: Text('Submitted, maybe'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      'Submit',
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

  getFormsDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();

    Map contact = snapshot.value;

    _title.text = contact['title'];
    _nameController.text = contact['body'];
    _url.text = contact['url'];
  }

  void saveForms() {
    String title = _title.text;
    String body = _nameController.text;
    String url = _url.text;
    Map<String, dynamic> contact = {
      'title': title,
      'body': body,
      'url': url,
    };

    _ref.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }

  List<Widget> _getSteps() {
    List<Widget> stepsTextFields = [];
    for (int i = 0; i < stepsList.length; i++) {
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
          color: (add) ? Colors.green : maroon,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

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
      _nameController.text = _EditFormsAState.stepsList[widget.index] ?? '';
    });

    return TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (v) => _EditFormsAState.stepsList[widget.index] = v,
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

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Forms'),
          centerTitle: true,
          backgroundColor: maroon,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Form Name',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _body,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Steps Here',
                ),
                maxLines: null,
              ),
              SizedBox(height: 15),
              TextField(
                controller: _url,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Form Hyperlink Here',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    saveForms();
                  },
                  child: Text('Add Form'),
                  style: ElevatedButton.styleFrom(
                      primary: maroon,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FormsAList())); //go to forms page
                  },
                  child: Text('Check Forms'),
                  style: ElevatedButton.styleFrom(
                      primary: maroon,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ));
  }

  getFormsDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();

    Map contact = snapshot.value;

    _title.text = contact['title'];
    _body.text = contact['body'];
    _url.text = contact['url'];
  }

  void saveForms() {
    String title = _title.text;
    String body = _body.text;
    String url = _url.text;
    Map<String, String> contact = {
      'title': title,
      'body': body,
      'url': url,
    };

    _ref.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }
}*/
*/
