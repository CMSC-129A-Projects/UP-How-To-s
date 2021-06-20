import 'package:flutter/material.dart';
import 'log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:uphowtos1/colors_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  DatabaseReference usersRef =
      FirebaseDatabase.instance.reference().child("users");
  bool authCheck = false;
  bool flag = false;
  double spc = 15;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  Future<bool> check() {
    if (flag == false) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: check,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(children: <Widget>[
                      AppTitle(),
                      spacing(0, spc),
                      authorizationCheck(),
                      spacing(0, spc),
                      nameInput(),
                      spacing(0, spc),
                      emailInput(),
                      spacing(0, spc),
                      passwordInput(),
                      spacing(0, spc),
                      loginButton(),
                    ])))),
      )),
    );
  }

  Widget authorizationCheck() => Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
                value: this.authCheck,
                onChanged: (bool value) => {
                      setState(() {
                        this.authCheck = value;
                      })
                    }),
            Flexible(
              child: Text(
                  'Using my UP email upon creating an account, I will continue to uphold good conduct while using this application.',
                  style:
                      TextStyle(fontSize: 15, fontFamily: 'Helvetica-Light')),
            )
          ],
        ),
      );

  Widget spacing(double x, double y) => SizedBox(
        height: y,
        width: x,
      );

  Widget loginButton() => Row(
        children: <Widget>[
          Expanded(child: Divider(color: Colors.grey)),
          spacing(0, spc),
          ElevatedButton(
            onPressed: () {
              if (passController.text.length < 7) {
                displayToastMessage(
                    "Password must be greater than 7 characters", context);
              } else if (!emailController.text.contains("@up.edu.ph") &&
                  emailController.text.toString() != "uphowtosofc@gmail.com") {
                displayToastMessage(
                    "Use UPmail and check your spelling!", context);
              } else if (authCheck == false) {
                displayToastMessage(
                    "Agree to terms and conditions above.", context);
              } else {
                registerNewUser(context);
              }
            },
            child: Text('Register'),
          ),
          spacing(0, spc),
          Expanded(child: Divider(color: Colors.grey)),
        ],
      );

  final FirebaseAuth auth = FirebaseAuth.instance;
  Timer timer;
  void registerNewUser(BuildContext context) async {
    try {
      final User user = (await auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passController.text))
          .user;
      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: nameController.text);
      user.sendEmailVerification();
      displayToastMessage(
          "If your email exists, a verification mail has been sent to you. Click the link provided to verify email and wait to be redirected to Log In Page.",
          context);
      flag = false;
      List<Key> x = [];
      List<Key> y = [];
      if (user != null) {
        Map userDataMap = {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passController.text.trim(),
          "posts": x,
          "comments": y,
          "avatarnumber": "0"
        };

        timer = Timer.periodic(Duration(seconds: 4), (timer) {
          displayToastMessage(
              "If your email exists, a verification mail has been sent to you. Click the link provided to verify email and wait to be redirected to Log In Page.",
              context);
          checkEmailVerified(userDataMap);
        });
      }
    } on FirebaseAuthException catch (error) {
      displayToastMessage(
          "Error: " + error.toString() + "Go to log in instead.", context);
    }

    /*
    */
  }

  Future<void> checkEmailVerified(Map userDataMap) async {
    User suser = auth.currentUser;

    await suser.reload();

    if (suser.emailVerified) {
      usersRef.child(suser.uid).set(userDataMap);
      timer.cancel();
      Navigator.of(context).pushNamed('/login');
    }
  }

  /*
  void registerNewUser(BuildContext context) async {
    //User _user;
    try {
      //Create Get Firebase Auth User
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);

      final User _user = (await auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          /*.catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    })*/
          )
          .user;

      if (_user != null) {
        Map userDataMap = {
          "email": emailController.text.trim(),
          "password": passController.text.trim()
        };
        usersRef.child(_user.uid).set(userDataMap);
        Navigator.of(context).pushNamed('/login'); // student version
      }
    } on FirebaseAuthException catch (error) {
      displayToastMessage("Error: " + error.toString(), context);
    }
  }*/

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
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
  bool isPasswordVisible = true;
  Widget nameInput() => TextField(
        controller: nameController,
        decoration: InputDecoration(
            hintText: 'Name',
            border: OutlineInputBorder(),
            suffixIcon: emailController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => emailController.clear(),
                  )),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );
  Widget passwordInput() => TextField(
        controller: passController,
        decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(),
            // errorText: 'Wrong password. Try Again',
            suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () =>
                    setState(() => isPasswordVisible = !isPasswordVisible))),
        keyboardType: TextInputType.visiblePassword,
        obscureText: isPasswordVisible,
      );
}
