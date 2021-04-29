import 'package:flutter/material.dart';
import 'package:uphowtos1/screens/Stafflist/staffItem.dart';
// import 'package:uphowtos1/screens/Stafflist/newStaffItem.dart';

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
              onPressed: () {},
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
        //color only used to see content limits
        // color: Colors.amber,
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            StaffItem(
              name: 'Ethan',
              position: 'developer',
              location: 'Talisay',
              description: '3rd Year',
            ),
            StaffItem(),
            StaffItem(),
          ],
        ),
      ),
      // ListView.separated(
      //   itemCount: staff.length,
      //   itemBuilder: (context, index) {},
      //   separatorBuilder: (BuildContext context, index) =>
      //       SizedBox(height: 10.0),
      // ),
    );
  }
}
