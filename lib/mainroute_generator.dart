import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/formsList.dart';
import 'package:uphowtos1/mainDashBoard.dart';
import 'formsEdit.dart';
import 'package:uphowtos1/mainLogIn.dart';
import 'mainDashBoard.dart';
import 'mainLogIn.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/dashboard':
        {}
        if (args is FirebaseUser) {
          return MaterialPageRoute(
            builder: (context) => Dashboard(args),
          );
        }
        return _errorRoute();
      case '/forms':
        return MaterialPageRoute(builder: (context) => FormsList());
      case '/edit':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/add':
        return MaterialPageRoute(builder: (context) => LoginPage());
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
