import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uphowtos1/colors_fonts.dart';

class EditForms extends StatefulWidget {
  final String contactKey;
  EditForms(this.contactKey);
  @override
  _EditFormsState createState() => _EditFormsState();
}

class _EditFormsState extends State<EditForms> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> stepslist = [null];
  static List<String> newStepsList;

  TextEditingController title;
  TextEditingController url;
  TextEditingController desc;
  TextEditingController steps;

  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    newStepsList = [];
    _ref = FirebaseDatabase.instance.reference().child('forms');
    title = TextEditingController();
    url = TextEditingController();
    desc = TextEditingController();
    steps = TextEditingController();
    getFormsDetail();
    setState(() {});
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
                  "Update Existing Form",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
            backgroundColor: maroon,
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
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Form Name:',
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
                            labelText:
                                "Sample: UP Cebu OUR Online Request Slip",
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
                                color: maroon,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter form description here';
                            return null;
                          }),
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
                    'Form Description:',
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
                          controller: this.desc,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText:
                                "Sample: Form for getting Official Transcript of Records",
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
                                color: maroon,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter form description here';
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
                      fontFamily: 'Helvetica',
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
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
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
                  padding: EdgeInsets.only(top: 5, left: 20),
                  child: Text(
                    '(optional)',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Helvetica',
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
                            labelText:
                                'Note: Start with https:// like https://www.cognitoforms.com/',
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
                                color: maroon,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter steps here';
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
                    },
                    child: Text(
                      'Edit Existing Form',
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

//gettins steps and its widgets
  List<Widget> _getSteps() {
    List<Widget> stepsTextFields = [];
    for (int i = 0; i < newStepsList.length; i++) {
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
              _addRemoveButton(i == newStepsList.length - 1, i),
            ],
          ),
        ),
      );
    }
    return stepsTextFields;
  }

//adding and removing textformfields for the steps
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          newStepsList.add(null);
        } else
          newStepsList.removeAt(index);
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
    desc.text = contact['desc'];
    stepslist = contact['body'];
    for (int i = 0; i < stepslist.length; i++) {
      if (stepslist[i] != '') {
        newStepsList.add(stepslist[i]);
        setState(() {});
      }
    }
  }

// edit form in database
  void click() {
    // bool flag = false;
    // for (int i = 0; i < newStepsList.length; i++) {
    //   if (newStepsList[i] == null) flag = true;
    // }
    if (title.text == '' || desc.text == '') {
      final snackBare = SnackBar(
          content: Text('Please fill empty fields or remove empty fields'));
      ScaffoldMessenger.of(context).showSnackBar(snackBare);
    } else {
      Map<String, dynamic> contact = {
        'title': title.text,
        'desc': desc.text,
        'url': url.text,
        'body': newStepsList,
      };
      _ref.child(widget.contactKey).update(contact).then((value) {
        Navigator.pop(context);
      });
      final snackBar = SnackBar(content: Text('Form edited'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

//rendering widget for steps which has multiple textformfields
class StepsTextFields extends StatefulWidget {
  final int index;
  StepsTextFields(this.index);

  @override
  _StepsTextFieldsState createState() => _StepsTextFieldsState();
}

class _StepsTextFieldsState extends State<StepsTextFields> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.text = _EditFormsState.newStepsList[widget.index] ?? '';
    });
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (v) => _EditFormsState.newStepsList[widget.index] = v,
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
