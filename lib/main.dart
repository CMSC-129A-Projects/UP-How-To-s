import 'package:flutter/material.dart';
import 'mainLogIn.dart';

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
/*
        "/logInPage": (_) => new LogInPage(),
        "/HomePage": (_) => new HomeFormsPage(),
        "/SignUpPage": (_) => new SignUpPage(),
        "/FormsPage": (_) => new FormsPage(),
        "/FormsEdit": (_) => new FormsEdit(),
        "/FormsAdd": (_) => new AddForms(),
        "/Home": (_) => new Home(),
        */
