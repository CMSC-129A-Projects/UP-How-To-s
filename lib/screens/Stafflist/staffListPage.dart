//great source material for popupmenubutton
//https://www.youtube.com/watch?v=TczSxNJB1gU&t=125s

import 'package:flutter/material.dart';
import 'package:uphowtos1/screens/Stafflist/staffItem.dart';
import 'package:uphowtos1/screens/Stafflist/newStaffItem.dart';

class StaffListPage extends StatefulWidget {
  @override
  _StaffListPageState createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  List<StaffItem> staff = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                _addNewStaff(context);
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
      ),
      drawer: Drawer(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children:
              staff.map((StaffItem) => buildItem(context, StaffItem)).toList(),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, StaffItem item) {
    if (item.toRemove == true) {
      setState(() {
        staff.remove(item);
      });
      return null;
    }
    return item;
  }

  void _addNewStaff(BuildContext context) async {
    final s = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewStaffItem()),
    );
    if (s != null) {
      setState(() {
        staff.add(s);
      });
    }
  }

  void _removeStaff(Key k) {
    for (StaffItem x in staff) {
      if (k == x.key) {
        setState(() {
          staff.remove(x);
        });
      }
    }
  }
}
