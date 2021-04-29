import 'package:uphowtos1/screens/DiscussionBoard/postHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'mainAuth.dart';
import 'mainDashBoard.dart';
import 'package:uphowtos1/screens/LogIn/LoginPage.dart';

class gmailSignIn extends StatefulWidget {
  @override
  _gmailSignInState createState() => _gmailSignInState();
}

class _gmailSignInState extends State<gmailSignIn> {
  FirebaseUser user;

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(user))) //admin version
            }
          else
            {
              if (user.email.contains("@up.edu.ph"))
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(user))) // student version
                }
              else
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LogInPage())) // invalid emails
                }
            },
        });
  }

  Widget googleLoginButton() {
    return OutlinedButton(
        onPressed: this.click,
        /*shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        splashColor: Colors.grey,
        borderSide: BorderSide(color: Colors.grey),*/
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Sign up with Google',
                        style: TextStyle(color: Colors.grey, fontSize: 18)))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }
}
