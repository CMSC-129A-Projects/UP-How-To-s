import 'package:flutter/material.dart';
import 'package:uphowtos1/main.dart';
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
          backgroundColor: maroon,
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () => _navigateAndAdd(context),
                    child: Icon(Icons.add, color: Colors.white))),
          ]),
      drawer: Drawer(),
      body: ListView.separated(
        itemCount: staff.length,
        itemBuilder: (context, index) {
          return Card(
              child: Column(children: <Widget>[
            Text(staff[index].name,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Helvetica',
                    color: Colors.white10)),
            SizedBox(height: 10.0),
            Text(
                '${staff[index].position}, can be found at ${staff[index].located}',
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Helvetica-Light',
                    color: Colors.white10)),
            SizedBox(height: 10.0),
          ]));
        },
        separatorBuilder: (BuildContext context, index) =>
            SizedBox(height: 10.0),
      ),
    );
  }

  _navigateAndAdd(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewStaffItem()));
    staff.add(result);
  }
}
