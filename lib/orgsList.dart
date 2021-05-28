import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/orgsHomePagee.dart';
import 'orgsDatabase.dart';
import 'orgsEdit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'orgs.dart';

final maroon = const Color(0xFF8A1538); // UP green
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class OrgsList extends StatefulWidget {
  OrgsList();
  @override
  _OrgsListState createState() => _OrgsListState();
}

class _OrgsListState extends State<OrgsList> {
  User user;
  Query _ref;
  List<Orgs> orgs = [];
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('orgs');

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('orgs')
        .orderByChild('name');
  }

  Widget _buildContactItem({Map contact}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/userorgsview', arguments: contact);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 6, offset: Offset(0, 4)),
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
                            builder: (_) => EditOrgs(
                                  newOrgs,
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
      ),
    );
  }

  void newOrgs(
      String name, List<String> officers, String contactinfo, String desc) {
    var org = new Orgs(name, officers, contactinfo, desc);
    org.setId(saveOrgs(org));
    this.setState(() {
      orgs.add(org);
    });
  }

  _showDeleteDialog({Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['name']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                style: ElevatedButton.styleFrom(primary: green),
              ),
              ElevatedButton(
                onPressed: () {
                  reference
                      .child(contact['key'])
                      .remove()
                      .whenComplete(() => Navigator.pop(context));
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(primary: green),
              )
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
                  "Organizations",
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
                            builder: (context) => OrgsHomePage(user)));
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
            backgroundColor: green,
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.only(top: 6.0),
        width: double.infinity,
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

List<Widget> _getSteps(List steps) {
  List<Widget> stepsTextFields = [];
  for (int i = 0; i < steps.length; i++) {
    if (steps[i] != null) {
      stepsTextFields.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                steps[i],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      );
    }
  }
  return stepsTextFields;
}

class ViewOrgs extends StatelessWidget {
  final Map contact;
  ViewOrgs({
    Key key,
    @required this.contact,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Organizations",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Helvetica',
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              backgroundColor: green,
            ),
          ),
          preferredSize: Size.fromHeight(60.0),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                            child: Row(
                              // mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Flexible(
                                Center(
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/seed/658/600',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  contact["name"],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    contact['desc'],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    color: green,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Contact Information',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  contact["contactinfo"],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    color: green,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(30),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Officers',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  ..._getSteps(contact["officers"]),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
