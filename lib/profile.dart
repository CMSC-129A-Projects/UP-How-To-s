import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart'; commented

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class Profile extends StatefulWidget {
  final User user;
  Profile(this.user);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //DatabaseReference _ref; commented
  int ava = 1;
  User cuser;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    cuser = auth.currentUser;
  //  _ref = FirebaseDatabase.instance.reference().child('forms'); commented
  }

/*
  getDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();
    Map contact = snapshot.value;
    ava = contact['avatarnumber'];
  }
*/
  _showStaffInfo(context) {
    // int num = contact[""];
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            scrollable: true,
            elevation: 6.0,
            backgroundColor: Colors.white,
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Change Avatar',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Helvetica-Bold',
                      color: maroon,
                    ),
                  ),
                ]),
            content: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/0.jpg"),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 20),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(maroon),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(maroon),
                        ),
                        onPressed: () {
                          this.save();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 20),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(maroon),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(maroon),
                        ),
                        onPressed: () {
                          this.next();
                        },
                        child: Text(
                          'Prev',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 20),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(maroon),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(maroon),
                        ),
                        onPressed: () {
                          this.prev();
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });

    //changeAvatar(num);
  }

/*
  changeAvatar(int ava) {
    _firebaseRef
        .child(key)
        .update({"timestamp": DateTime.now().millisecondsSinceEpoch});
  }
*/
  void click() {
    _showStaffInfo(context);
  }

  void pclick() {
    _showStaffInfo(context);
  }

  void cclick() {
    _showStaffInfo(context);
  }

  void save() {
    _showStaffInfo(context);
  }

  void prev() {
    _showStaffInfo(context);
  }

  void next() {
    _showStaffInfo(context);
  }

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
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "User Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Helvetica',
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
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    cuser.displayName,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    FirebaseAuth.instance.currentUser.email,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    "For concerns regarding your account, \n please contact Student Council.",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.all(7),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/0.jpg"),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Postsss',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            //..._getSteps(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(maroon),
                      backgroundColor: MaterialStateProperty.all<Color>(maroon),
                    ),
                    onPressed: () {
                      this.click();
                    },
                    child: Text(
                      'Change Avatar',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(maroon),
                      backgroundColor: MaterialStateProperty.all<Color>(maroon),
                    ),
                    onPressed: () {
                      this.pclick();
                    },
                    child: Text(
                      'Posts',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(maroon),
                      backgroundColor: MaterialStateProperty.all<Color>(maroon),
                    ),
                    onPressed: () {
                      this.cclick();
                    },
                    child: Text(
                      'Comments',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      /*
      Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          children: <Widget>[
            myItems(
              'https://i.imgur.com/NdSHMGZ.png',
              "Forms & Processes",
              "Find formats and guides for academic and non academic forms here.",
              1,
              "/forms",
            ),
            myItems(
              'https://i.imgur.com/NdSHMGZ.png',
              "Discussion Board",
              "Got questionds? See our discussion board for answers and more!",
              3,
              "/post",
            ),
            myItems(
              'https://i.imgur.com/NdSHMGZ.png',
              "Personnel Directory",
              "Get to know our very own UPC people here.",
              2,
              "/staff",
            ),
            myItems(
              'https://i.imgur.com/NdSHMGZ.png',
              "Organization Board",
              "Check out existing organizations and what they have in store!",
              4,
              "/orgs",
            ),
            myItems(
              'https://i.imgur.com/NdSHMGZ.png',
              "User Profile",
              "Manage your account and past posts.",
              5,
              "/prof",
            )
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, 165.0),
            StaggeredTile.extent(1, 165.0),
            StaggeredTile.extent(1, 165.0),
            StaggeredTile.extent(1, 165.0),
            StaggeredTile.extent(2, 165.0),
          ],
        ),
      ),*/
    );
  }
}
