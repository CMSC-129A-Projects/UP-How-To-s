import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

Color maroon = Color(0xFF8A1538);

class LogInPage extends StatefulWidget {
  const LogInPage({Key key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  DatabaseReference usersRef =
      FirebaseDatabase.instance.reference().child("users");
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool isPasswordVisible = true;
  bool hasSubmitted = true;
  String password = "";
  double spc = 10;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(children: <Widget>[
                AppTitle(),
                spacing(spc, 0),
                emailInput(),
                spacing(spc, 0),
                passwordInput(),
                spacing(spc, 0),
                loginButton(),
                spacing(spc, 0),
                signUpButton()
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput() => TextField(
        controller: emailController,
        decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(),
            suffixIcon: emailController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => emailController.clear(),
                  )),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      );

  Widget passwordInput() => TextField(
        controller: passController,
        decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(),
            errorText: validatePassword(passController.text),
            suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () =>
                    setState(() => isPasswordVisible = !isPasswordVisible))),
        keyboardType: TextInputType.visiblePassword,
        obscureText: isPasswordVisible,
      );
  String validatePassword(String value) {
    if (!(value.length > 8) && value.isNotEmpty) {
      return "Password should contain more than 7 characters";
    }
    return null;
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  Widget spacing(double x, double y) => SizedBox(
        height: x,
        width: y,
      );

  Widget loginButton() => Row(
        children: <Widget>[
          Expanded(child: Divider(color: Colors.grey)),
          spacing(0, spc),
          ElevatedButton(
            onPressed: () {
              if (passController.text.length < 7 || emailController == null) {
                displayToastMessage("Invalid email or password.", context);
              } else if ((!emailController.text.contains("@up.edu.ph")) &&
                  !(emailController.text == "uphowtosofc@gmail.com")) {
                displayToastMessage("Use UPmail", context);
              } else {
                loginAndAunthenticate(context);
              }
            },
            child: Text('Log In?'),
          ),
          spacing(0, spc),
          Expanded(child: Divider(color: Colors.grey)),
        ],
      );

  Widget signUpButton() => TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/reg'); // st
      },
      child: Text('Need an Account? Sign Up Here'));

  final FirebaseAuth auth = FirebaseAuth.instance;

  void loginAndAunthenticate(BuildContext context) async {
    /* final User _user = (await auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passController.text)
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
      print(errMsg.toString() + "sssssssssssssssssssssssssss");
    }))
        .user;*/
    User _user;
    try {
      //Create Get Firebase Auth User
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);

      //Success
      Navigator.of(context)
          .pushNamed('/dashboard', arguments: _user); //); // student version

    } on FirebaseAuthException catch (error) {
      displayToastMessage("Error: " + error.toString(), context);
    }

    /*
    .catch((error)=> {
            console.error('Error signInWithEmailAndPassword', email, password, error.name, error.message);
            throw new Error(error.message);
        });
    */
/*
    if (_user != null) {
      usersRef.child(_user.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.of(context).pushNamed('/dashboard',
              arguments: _user); //); // student version
        }
      });
    } else {
      auth.signOut();
    }*/
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double logoDimensions = 100;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: logoDimensions, maxWidth: logoDimensions),
            child: Image(image: AssetImage('assets/UP_Cebu_logo_1.png'))),
        Text(
          "UP\nHow To's",
          style: TextStyle(
            fontFamily: 'Helvetica-Bold',
            fontSize: 45,
            fontWeight: FontWeight.w800,
            color: maroon,
            shadows: [
              Shadow(color: Colors.grey, blurRadius: 6, offset: Offset(0, 4))
            ],
          ),
        ),
      ],
    );
  }
}
