import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/staffHomePage.dart';
import 'staffDatabase.dart';
import 'package:uphowtos1/mainDrawerDetails.dart';
import 'staffEdit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'staff.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class StaffList extends StatefulWidget {
  StaffList();

  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  FirebaseUser user;
  Query _ref;
  List<Staff> staffs = [];
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('staff');

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('staff')
        .orderByChild('name');
  }

  Widget _buildContactItem({Map contact}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 6, offset: Offset(0, 4)),
          ]),
      child: Row(children: <Widget>[
        Expanded(
          flex: 8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contact['name'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  contact['department'],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Helvetica',
                    color: Colors.grey[850],
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  contact['position'],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Helvetica',
                    color: Colors.grey[850],
                  ),
                ),
                /*Align(
                  alignment: Alignment.topRight,
                  child: */
              ]),
        ),
        Expanded(
          flex: 1,
          child: PopupMenuButton<int>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            onSelected: (item) {
              switch (item) {
                case 0:
                  //Edit Item
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditStaff(
                                newStaff,
                                user,
                                contactKey: contact['key'],
                              )));
                  break;
                case 1:
                  //Remove Item
                  _showDeleteDialog(contact: contact);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Edit'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text('Remove'),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void newStaff(String name, String location, String position, String email,
      String department) {
    var staff = new Staff(name, location, position, email, department);
    staff.setId(saveStaff(staff));
    this.setState(() {
      staffs.add(staff);
    });
  }

  _showDeleteDialog({Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete this staff record?'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    reference
                        .child(contact['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
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
              'Personnel Directory',
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
        backgroundColor: maroon,
        elevation: 4.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StaffHomePage(user)));
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white70,
              ),
              splashRadius: 24.0,
              tooltip: 'Add Staff',
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;
            return _buildContactItem(contact: contact);
          },
        ),
      ),
    );
  }
}
