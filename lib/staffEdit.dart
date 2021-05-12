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
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class EditStaff extends StatefulWidget {
  String contactKey;
  final Function(String, String, String, String, String) callback;
  final FirebaseUser user;
  EditStaff(this.callback, this.user, {this.contactKey});

  @override
  _EditStaffState createState() => _EditStaffState();
}

class _EditStaffState extends State<EditStaff> {
  TextEditingController name = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController email = TextEditingController();
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('staff');
    name = TextEditingController();
    position = TextEditingController();
    location = TextEditingController();
    department = TextEditingController();
    email = TextEditingController();
    getStaffDetail();
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
                'Edit Staff',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
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
          backgroundColor: maroon,
          elevation: 4.0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //FOR NAME
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Name',
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
                        controller: this.name,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: OutlineInputBorder(),
                          hintText: 'Dr. Juanita dela Cruz',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //FOR LOCATION
            Row(
              //Download Forms Text
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Department:',
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
                        controller: this.department,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: OutlineInputBorder(),
                          hintText: 'Department of Computer Science',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //FOR DETAILS
            Row(
              //Download Forms Text
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Position:',
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
                        controller: this.position,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: OutlineInputBorder(),
                          hintText: 'College Secretary',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //FOR DEPARTMENT
            Row(
              //Download Forms Text
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Office Location:',
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
                        controller: this.location,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: OutlineInputBorder(),
                          hintText: 'AS Hall Left Wing Room 100',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //POSTIION
            Row(
              //Download Forms Text
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'UP email',
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
                        controller: this.email,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: OutlineInputBorder(),
                          hintText: 'jzdelacruz@up.edu.ph',
                        ),
                      ),
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

  getStaffDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();
    Map contact = snapshot.value;
    name.text = contact['name'];
    position.text = contact['position'];
    location.text = contact['location'];
    email.text = contact['email'];
    department.text = contact['department'];
  }

  void click() {
    if (name.text == '' ||
        location.text == '' ||
        email.text == '' ||
        department.text == '' ||
        position.text == '') {
      final snackBar = SnackBar(
          content: Text('Please fill empty fields or remove empty steps'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      widget.callback(
          name.text, position.text, location.text, email.text, department.text);
      FocusScope.of(context).unfocus();
      name.clear();
      position.clear();
      location.clear();
      email.clear();
      department.clear();
      _ref.child(widget.contactKey).remove();
      Navigator.of(context).pushNamed('/staff');
      final snackBar = SnackBar(content: Text('Staff record edited'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
