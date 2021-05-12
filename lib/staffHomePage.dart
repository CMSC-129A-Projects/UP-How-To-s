import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'staff.dart';
import 'staffDatabase.dart';
import 'staffAdd.dart';
import 'staffList.dart';

class StaffHomePage extends StatefulWidget {
  final FirebaseUser user;
  StaffHomePage(this.user);
  @override
  _StaffHomePageState createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  FirebaseUser user;
  List<Staff> staffs = [];

  void newStaff(String name, String location, String position, String email,
      String department) {
    var staff = new Staff(name, location, position, email, department);
    staff.setId(saveStaff(staff));
    this.setState(() {
      staffs.add(staff);
    });
  }

  void updateStaff() {
    getAllStaff().then((staffs) => {
          this.setState(() {
            this.staffs = staffs;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateStaff();
  }

  @override
  Widget build(BuildContext context) {
    return StaffInputWidget(this.newStaff, this.user);
  }
}

class StaffListPage extends StatefulWidget {
  final FirebaseUser user;
  StaffListPage(this.user);
  @override
  _StaffListPageState createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  FirebaseUser user;
  List<Staff> staffs = [];

  void newStaff(String name, String location, String position, String email,
      String department) {
    var staff = new Staff(name, location, position, email, department);
    staff.setId(saveStaff(staff));
    this.setState(() {
      staffs.add(staff);
    });
  }

  void updateStaff() {
    getAllStaff().then((staffs) => {
          this.setState(() {
            this.staffs = staffs;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Personnel Diretory')),
        body: Column(children: <Widget>[
          Expanded(child: StaffList()),
        ]));
  }
}
