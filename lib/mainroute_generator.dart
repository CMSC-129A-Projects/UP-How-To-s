import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/formsList.dart';
import 'package:uphowtos1/mainDashBoard.dart';
import 'staffList.dart';
import 'package:uphowtos1/mainLogIn.dart';
import 'mainDashBoard.dart';
import 'mainLogIn.dart';
import 'userformsList.dart';
import 'usermainDashboard.dart';
import 'userstaffList.dart';

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
      case '/userdashboard':
        {}
        if (args is FirebaseUser) {
          return MaterialPageRoute(
            builder: (context) => UserDashboard(args),
          );
        }
        return _errorRoute();
      case '/forms':
        return MaterialPageRoute(builder: (context) => FormsList());
      case '/edit':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/add':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/staff':
        return MaterialPageRoute(builder: (context) => StaffList());
      case '/userforms':
        return MaterialPageRoute(builder: (context) => UserFormsList());
      case '/userstaff':
        return MaterialPageRoute(builder: (context) => UserStaffList());
      case '/userformsview':
        return MaterialPageRoute(
            builder: (context) => ViewForms(
                  contact: args,
                ));
      case '/userstaffview':
        return MaterialPageRoute(builder: (context) => UserStaffList());

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
