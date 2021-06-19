import 'package:flutter/material.dart';
import 'mainDashBoard.dart';
import 'account_authorization/log_in.dart';
import 'account_authorization/register.dart';
import 'account_authorization/profile.dart';

import 'forms/formsHomePage.dart';
import 'forms/formsView.dart';
import 'forms/formsEdit.dart';

import 'orgboard/orgsHomePage.dart';
//import 'orgboard/orgsView.dart';
import 'orgboard/orgsEdit.dart';
import 'orgboard/orgsList.dart';
import 'personnel/staffHomePage.dart';
//import 'personnel/staffView.dart';
import 'personnel/staffEdit.dart';

import 'discboard/pnHomePage.dart';
import 'discboard/postAdd.dart';
import 'discboard/pnPostView.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LogInPage());
      case '/reg':
        return MaterialPageRoute(builder: (context) => RegPage());
      case '/login':
        return MaterialPageRoute(builder: (context) => LogInPage());
      case '/dashboard':
        return MaterialPageRoute(builder: (context) => Dashboard());

      case '/forms':
        return MaterialPageRoute(builder: (context) => FormsHomePage());
      case '/formsview':
        return MaterialPageRoute(
            builder: (context) => ViewForms(contact: args));
      case '/formsedit':
        return MaterialPageRoute(builder: (context) => EditForms(args));

      case '/staff':
        return MaterialPageRoute(builder: (context) => StaffHomePage());
      /*case '/staffview':
        return MaterialPageRoute(
            builder: (context) => ViewForms(contact: args));*/
      case '/staffedit':
        return MaterialPageRoute(builder: (context) => EditStaff(args));

      case '/orgs':
        return MaterialPageRoute(builder: (context) => OrgsList());
      case '/orgsview':
        return MaterialPageRoute(builder: (context) => ViewOrgs(contact: args));
      case '/orgsedit':
        return MaterialPageRoute(builder: (context) => EditOrgs(args));

      case '/post':
        return MaterialPageRoute(builder: (context) => NewPostHomePage(args));
      case '/postinput':
        return MaterialPageRoute(
            builder: (context) => PostsInputWidget(args, args));
      case '/postview':
        return MaterialPageRoute(builder: (context) => ViewPostNew(args, args));

      case '/prof':
        return MaterialPageRoute(builder: (context) => Profile());
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
