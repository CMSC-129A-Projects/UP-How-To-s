import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'staffList.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class EditStaff extends StatefulWidget {
  String contactKey;
  EditStaff({this.contactKey});
  @override
  _EditStaffState createState() => _EditStaffState();
}

class _EditStaffState extends State<EditStaff> {
  TextEditingController _name, _emailadd, _position, _where, _department;
  DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _emailadd = TextEditingController();
    _position = TextEditingController();
    _where = TextEditingController();
    _department = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('staff');
    getStaffDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Staff'),
          centerTitle: true,
          backgroundColor: maroon,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _name,
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
                controller: _department,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Which Department',
                ),
              ),
              TextField(
                controller: _position,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Position',
                ),
              ),
              TextField(
                controller: _where,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Office Location',
                ),
              ),
              TextField(
                controller: _emailadd,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Email Add/Contact Details',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    saveStaff();
                  },
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
                                StaffList())); //go to forms page
                  },
                  child: Text('Check All Staff'),
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

  getStaffDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();

    Map contact = snapshot.value;

    _name.text = contact['name'];
    _department.text = contact['department'];
    _position.text = contact['position'];
    _where.text = contact['where'];
    _emailadd.text = contact['emailadd'];
  }

  void saveStaff() {
    String name = _name.text;
    String position = _position.text;
    String department = _department.text;
    String where = _where.text;
    String emailadd = _emailadd.text;
    Map<String, String> contact = {
      'name': name,
      'position': position,
      'department': department,
      'where': where,
      'emailadd': emailadd,
    };

    _ref.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }
}
