import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

final maroon = const Color(0xFF8A1538); // UP MAROON

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UP How Tos',
      theme: ThemeData(
        primaryColor: maroon,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

///adawdawdawdw
///dawadawd
