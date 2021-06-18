import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uphowtos1/colors_fonts.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile(this.user);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseReference _ref;
  User cuser;
  String cuid;
  String savatar = "";
  String avatar = "";
  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    cuser = auth.currentUser;
    cuid = cuser.uid;
    super.initState();
  }

  getFormsDetail() async {
    _ref = FirebaseDatabase.instance.reference().child('users');
    DataSnapshot snapshot = await _ref.child(cuid).once();
    Map contact = snapshot.value;
    avatar = contact['avatarnumber'].toString();
    savatar = "assets/" + avatar + ".png";
    return savatar;
  }

  /*
Future <LoginPage> _signOut()  async{
    await FirebaseAuth.instance.signOut();
}
FlatButton(
  onPressed: () {
  setState(() {});
signOut(),
Navigator.of(context)
  .pushAndRemoveUntil(
    Profile(
      builder: (context) => LoginPage()
    ),
  () => false,
); },
  child: Text(
                      Logout,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),*/
  picwidget() {
    getFormsDetail();
    if (savatar != "assets/0.png") print("YEAHHHH");
    return Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: CircleAvatar(
          radius: 65,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(savatar),
        ));
  }

  _showStaffInfo(context) {
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
                      backgroundImage: AssetImage(savatar),
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
                          Navigator.pop(context, true);
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
                          Navigator.pop(context, true);
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
                          Navigator.pop(context, true);
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
  }

  void click() {
    _showStaffInfo(context);
  }

  void pclick() {
    _showStaffInfo(context);
  }

  void cclick() {
    _showStaffInfo(context);
  }

  void save() {}

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
        body:
            /*
      Container(
        child: FutureBuilder(
        future: getFormsDetail()),
      ),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
            return 
      */
            SingleChildScrollView(
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
              picwidget(),
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
                        print(savatar);
                        print("==================================+===");
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
                        foregroundColor:
                            MaterialStateProperty.all<Color>(maroon),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(maroon),
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
                        foregroundColor:
                            MaterialStateProperty.all<Color>(maroon),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(maroon),
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
        ));
  }
}
