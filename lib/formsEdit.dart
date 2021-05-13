import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/mainDrawerDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'mainDrawerDetails.dart';

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
      _nameController.text = _EditFormsState.stepsList[widget.index] ?? '';
    });
    return TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (v) => _EditFormsState.stepsList[widget.index] = v,
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

class EditForms extends StatefulWidget {
  String contactKey;
  final Function(String, List<String>, String) callback;
  final FirebaseUser user;
  EditForms(this.callback, this.user, {this.contactKey});

  @override
  _EditFormsState createState() => _EditFormsState();
}

class _EditFormsState extends State<EditForms> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  List<dynamic> word = [null];
  static List<String> stepsList;
  //this is where the list of steps is placed, manipulate this para masulod/makakuha from the database

  TextEditingController title = TextEditingController();
  TextEditingController url = TextEditingController();
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    stepsList = [null];
    _ref = FirebaseDatabase.instance.reference().child('forms');
    title = TextEditingController();
    url = TextEditingController();
    _nameController = TextEditingController();
    getFormsDetail();
    setState(() {});
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
                      int notempty = 0;
                      for (int ctr = 0; ctr < stepsList.length; ctr++) {
                        if (stepsList[ctr] != null) notempty = notempty + 1;
                      }
                      if (notempty > 0) {
                        for (int ctr = 0; ctr < stepsList.length; ctr++) {
                          if (stepsList[ctr] == null) {
                            stepsList.removeAt(ctr);
                            setState(() {});
                          }
                        }
                        this.click();
                      } else {
                        final snackBar = SnackBar(
                            content: Text(
                                'Please fill empty fields or remove empty steps'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
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
    word = contact['body'];
    for (int i = 0; i < word.length; i++) {
      if (word[i] != '') {
        stepsList.add(word[i]);
        setState(() {});
      }
    }
    //_getSteps();
  }

  void click() {
    widget.callback(title.text, stepsList, url.text);
    FocusScope.of(context).unfocus();
    title.clear();
    _nameController.clear();
    url.clear();
    _ref.child(widget.contactKey).remove();
    Navigator.of(context).pushNamed('/forms');
    final snackBar = SnackBar(content: Text('Form edited'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
