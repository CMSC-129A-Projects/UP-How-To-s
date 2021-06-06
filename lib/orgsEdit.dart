import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// import 'package:uphowtos1/orgs.dart'; //commented because not in used, uncomment if needed -Marc

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class OrgsTextFields extends StatefulWidget {
  final int index;
  OrgsTextFields(this.index);

  @override
  _OrgsTextFieldsState createState() => _OrgsTextFieldsState();
}

class _OrgsTextFieldsState extends State<OrgsTextFields> {
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
      _nameController.text = _EditOrgsState.officersList[widget.index] ?? '';
    });
    return TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (v) => _EditOrgsState.officersList[widget.index] = v,
        decoration: InputDecoration(
          labelText: 'Sample: President: John Paul Cruz',
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
          if (v.trim().isEmpty) return 'Please enter step here';
          return null;
        });
  }
}

class EditOrgs extends StatefulWidget {
  final String contactKey; //this is edited to have final -Marc
  final Function(String, List<String>, String, String) callback;
  final User user;
  EditOrgs(this.callback, this.user, {this.contactKey});

  @override
  _EditOrgsState createState() => _EditOrgsState();
}

class _EditOrgsState extends State<EditOrgs> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  List<dynamic> word = [null];
  static List<String> officersList;
  //this is where the list of steps is placed, manipulate this para masulod/makakuha from the database

  TextEditingController name = TextEditingController();
  TextEditingController contactinfo = TextEditingController();
  TextEditingController desc = TextEditingController();
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    officersList = [];
    _ref = FirebaseDatabase.instance.reference().child('orgs');
    name = TextEditingController();
    contactinfo = TextEditingController();
    desc = TextEditingController();
    _nameController = TextEditingController();
    getOrgsDetail();
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
                  "Update Organization",
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
                    'Organization Name:',
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
                          controller: this.name,
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
                                color: green,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v.trim().isEmpty)
                              return 'Please enter officer name here';
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
                    'Org Description:',
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
                                "Sample: For students who appreciate Japanese films and content!",
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
                              return 'Please enter org description here';
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
                    'Officers:  ',
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
                    'Contant Info: ',
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
                          controller: this.contactinfo,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Sample: nichi@gmail.com 09123456789',
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
                              return 'Please enter officers here';
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
                      'Update Existing Org',
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
    for (int i = 0; i < officersList.length; i++) {
      stepsTextFields.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: Container(child: OrgsTextFields(i)),
              ),
              SizedBox(
                width: 10,
              ),
              _addRemoveButton(i == officersList.length - 1, i),
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
          officersList.add(null);
        } else
          officersList.removeAt(index);
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

  getOrgsDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();
    Map contact = snapshot.value;
    name.text = contact['name'];
    contactinfo.text = contact['contactinfo'];
    desc.text = contact['desc'];
    word = contact['officers'];
    for (int i = 0; i < word.length; i++) {
      if (word[i] != '') {
        officersList.add(word[i]);
        setState(() {});
      }
    }
    //_getSteps();
  }

  void click() {
    widget.callback(name.text, officersList, contactinfo.text, desc.text);
    FocusScope.of(context).unfocus();
    name.clear();
    _nameController.clear();
    contactinfo.clear();
    desc.clear();
    officersList = [null];
    _ref.child(widget.contactKey).remove();
    Navigator.of(context).pushNamed('/orgs');
    final snackBar = SnackBar(content: Text('Org record edited'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
