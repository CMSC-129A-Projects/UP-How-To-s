//great source material for popupmenubutton
//https://www.youtube.com/watch?v=TczSxNJB1gU&t=125s

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/screens/stafflist/staffItem.dart';
import 'package:uphowtos1/screens/stafflist/newStaffItem.dart';
import 'package:uphowtos1/screens/Stafflist/staffList.dart';

class StaffListPage extends StatefulWidget {
  @override
  _StaffListPageState createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  @override
  Widget build(BuildContext context) {
    final staff = context.watch<StaffList>();
    return Scaffold(
      appBar: _myAppBar(context, staff),
      drawer: Drawer(),
      body: _myBody(context, staff),
    );
  }

  Widget _myAppBar(BuildContext context, StaffList staff) => AppBar(
        title: Text('Staff List'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewStaffItem()),
                );
              },
              icon: Icon(
                Icons.add,
                color: Colors.white70,
              ),
              splashRadius: 24.0,
              tooltip: 'Add Staff',
            ),
          ),
        ],
      );

  Widget _myBody(BuildContext context, StaffList staff) => Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: staff.staff.length,
          itemBuilder: (context, index) {
            return StaffItem(index: index);
          },
          separatorBuilder: (context, _) => SizedBox(height: 10.0),
        ),
      );
}
