/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/screens/stafflist/staffListPage.dart';
import 'package:uphowtos1/screens/Stafflist/staffList.dart';
// import 'package:uphowtos1/screens/LogIn/RegistrationPage.dart';
// import 'package:uphowtos1/screens/LogIn/feLoginPage.dart';
// import 'mainLogIn.dart';

void main() {
  runApp(MyApp());
}

final maroon = const Color(0xFF8A1538); // UP MAROON

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider is a state management feature in flutter
    // I used this kind of provider since it the data always changes and i need
    // to rebuild it everytime a change is made
    return ChangeNotifierProvider(
      // create instantiates a StaffList which makes all the children of main
      // have access to StaffList
      create: (BuildContext context) => StaffList(),
      child: MaterialApp(
        title: 'UP How Tos',
        theme: ThemeData(
          primaryColor: maroon,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StaffListPage(),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mainRouteGenerator.dart';
import 'colors_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(MyApp());
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UP How Tos',
      theme: ThemeData(
        primaryColor: maroon,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void main() {
  runApp(MyApp());
}

final maroon = const Color(0xFF8A1538); // UP MAROON

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => new DiscussionList(),
      child: MaterialApp(
        title: 'UP How Tos',
        theme: ThemeData(
          primaryColor: maroon,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: DiscussionPage(),
        // initialRoute: '/',
        // onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}*/ /*
import 'package:flutter/material.dart';
import 'package:uphowtos1/disPage.dart';
import 'mainroute_generator.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';

void main() {
  runApp(MyApp());
}

final maroon = const Color(0xFF8A1538); // UP MAROON

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => new DiscussionList(),
      child: MaterialApp(
        title: 'UP How Tos',
        theme: ThemeData(
          primaryColor: maroon,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: DiscussionPage(),
        // initialRoute: '/',
        // onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
*/
