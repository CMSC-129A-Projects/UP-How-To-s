import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/formsHomePage.dart';
import 'formsDatabase.dart';
//import 'package:uphowtos1/mainDrawerDetails.dart';
import 'formsEdit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forms.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class FormsList extends StatefulWidget {
  FormsList();
  @override
  _FormsListState createState() => _FormsListState();
}

class _FormsListState extends State<FormsList> {
  FirebaseUser user;
  Query _ref;
  List<Forms> forms = [];
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('forms');

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('forms')
        .orderByChild('title');
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
                  contact['title'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  contact['desc'],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Helvetica',
                    color: Colors.grey[850],
                  ),
                ),
                SizedBox(height: 2.0),
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
                          builder: (_) => EditForms(
                                newForms,
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

  void newForms(String title, List<String> body, String url, String desc) {
    var form = new Forms(title, body, url, desc);
    form.setId(saveForms(form));
    this.setState(() {
      forms.add(form);
    });
  }

  _showDeleteDialog({Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['title']}'),
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
                  "Forms & Processes",
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormsHomePage(user)));
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  splashRadius: 24.0,
                  tooltip: 'Add Staff',
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            backgroundColor: maroon,
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
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
      ),
    );
  }
}
