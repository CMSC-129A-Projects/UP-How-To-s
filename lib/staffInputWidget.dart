import 'package:flutter/material.dart';
import 'staffHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class StaffTInputWidget extends StatefulWidget {
  final Function(String, String, String, String, String) callback;
  StaffTInputWidget(this.callback, this.user);

  final FirebaseUser user;

  @override
  _StaffTInputWidgetState createState() => _StaffTInputWidgetState();
}

class _StaffTInputWidgetState extends State<StaffTInputWidget> {
  FirebaseUser user;
  final name = TextEditingController();
  final position = TextEditingController();
  final department = TextEditingController();
  final emailadd = TextEditingController();
  final where = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    name.dispose();
    position.dispose();
    department.dispose();
    emailadd.dispose();
    where.dispose();
  }

  void click() {
    widget.callback(
        name.text, position.text, department.text, where.text, emailadd.text);
    FocusScope.of(context).unfocus();
    name.clear();
    position.clear();
    department.clear();
    emailadd.clear();
    where.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Staff'),
          centerTitle: true,
          backgroundColor: maroon,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: this.name,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Name',
                ),
                maxLines: null,
              ),
              SizedBox(height: 15),
              TextField(
                controller: this.department,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Department',
                ),
              ),
              TextField(
                controller: this.position,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Position',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: this.where,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Office Location',
                ),
                maxLines: null,
              ),
              SizedBox(height: 15),
              TextField(
                controller: this.emailadd,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Email Address / Contact Details',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: this.click,
                  child: Text('Add Staff'),
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
                                StaffListPage(user))); //go to forms page
                  },
                  child: Text('Check Staff'),
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
}
