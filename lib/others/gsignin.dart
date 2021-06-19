/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'mainAuth.dart';
final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: Body());
  }
}
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {
  User user;
  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }
  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          if (user.email.contains("uphowtosofc@gmail.com"))
            {
              Navigator.of(context)
                  .pushNamed('/dashboard', arguments: user), //admin version
            }
          else
            {
              if (user.email.contains("@up.edu.ph"))
                {
                  Navigator.of(context).pushNamed('/userdashboard',
                      arguments: user), // student version
                }
              else
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage())) // invalid emails
                }
            },
        });
  }
  Widget googleLoginButton() {
    return OutlinedButton(
        onPressed: this.click,
        style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Sign in with Google',
                        style: TextStyle(color: Colors.grey, fontSize: 25)))
              ],
            )));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally,
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "UP How To's is a student-made application.\nYou can only access the beta version of this app by signing in using your UPmail.\nYour words and actions always leave traces.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Helvetica',
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Align(alignment: Alignment.bottomCenter, child: googleLoginButton()),
      ],
    ));
  }
}
*/