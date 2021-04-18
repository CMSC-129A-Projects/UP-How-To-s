/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uphowtos1/formsTwo.dart';
import 'package:uphowtos1/mainDrawerDetails.dart';
import 'package:uphowtos1/postHomePage.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class AdminHomePage extends StatefulWidget {
  final FirebaseUser user;
  AdminHomePage(this.user);
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Admin page')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage())); //go to forms page
                },
                child: Text('Forms and Processes'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(250, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            )),
            Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DrawerDetails())); //go to staff page
                },
                child: Text('Personnel Directory'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(250, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            )),
            Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DrawerDetails())); //go to map page
                },
                child: Text('Map'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(250, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            )),
            Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(user))); //go to board page
                },
                child: Text('Discussion Board'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(250, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            )),
            Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(user))); //go to orgs page
                },
                child: Text('Organizations'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(250, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            )),
          ],
        ));
  }
}
*/
