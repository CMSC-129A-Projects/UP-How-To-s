import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/disPage.dart';
import 'package:uphowtos1/formsList.dart';
import 'package:uphowtos1/mainDashBoard.dart';
import 'staffList.dart';
import 'mainDashBoard.dart';
import 'userformsList.dart';
import 'usermainDashboard.dart';
import 'userstaffList.dart';
import 'orgsList.dart';
import 'postLists.dart';
import 'mainnewLogin.dart';
import 'mainregister.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LogInPage());
      case '/dashboard':
        {}
        if (args is User) {
          return MaterialPageRoute(
            builder: (context) => Dashboard(args),
          );
        }
        return _errorRoute();
      case '/userdashboard':
        {}
        if (args is User) {
          return MaterialPageRoute(
            builder: (context) => UserDashboard(args),
          );
        }
        return _errorRoute();
      case '/reg':
        return MaterialPageRoute(builder: (context) => RegPage());
      case '/login':
        return MaterialPageRoute(builder: (context) => LogInPage());
      case '/forms':
        return MaterialPageRoute(builder: (context) => FormsList());
      case '/staff':
        return MaterialPageRoute(builder: (context) => StaffList());
      case '/userforms':
        return MaterialPageRoute(builder: (context) => UserFormsList());
      case '/userstaff':
        return MaterialPageRoute(builder: (context) => UserStaffList());
      case '/orgs':
        return MaterialPageRoute(builder: (context) => OrgsList());
      case '/post':
        return MaterialPageRoute(builder: (context) => DiscussionPage());
      case '/userformsview':
        return MaterialPageRoute(
            builder: (context) => ViewForms(
                  contact: args,
                ));
      case '/userorgsview':
        return MaterialPageRoute(
            builder: (context) => ViewOrgs(
                  contact: args,
                ));
      case '/userpostview':
        return MaterialPageRoute(
            builder: (context) => ViewPost(
                  contact: args,
                ));
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
