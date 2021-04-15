import 'package:flutter/material.dart';
import 'ScreenUI.dart';
//import 'DrawerDetails.dart';
import 'FormList.dart';
//import 'dart:ui' as ui;
//import 'dart:mirrors';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

void main() {
  runApp(MaterialApp(home: UpHowTo()));
}

class UpHowTo extends StatefulWidget {
  @override
  UpHowToState createState() => new UpHowToState();
}

class UpHowToState extends State<UpHowTo> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LogInPage(),
      routes: {
        "/logInPage": (_) => new LogInPage(),
        "/HomePage": (_) => new HomePage(),
        "/SignUpPage": (_) => new SignUpPage(),
        "/FormsPage": (_) => new FormsPage(),
      },
    );
  }
}


