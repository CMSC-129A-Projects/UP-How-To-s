import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            errorText: validatePassword(),
            suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () =>
                    setState(() => isPasswordVisible = !isPasswordVisible))),
        keyboardType: TextInputType.visiblePassword,
        obscureText: isPasswordVisible,
      );
  String validatePassword() {
    if (passController.text.length < 8 && passController.text.length != 0) {
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
            child: Text('Log In'),
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
    try {
      final User _user = (await auth.signInWithEmailAndPassword(
              email: emailController.text, password: passController.text))
          .user;
      //Success
      if (_user != null) {
        if (emailController.text == "uphowtosofc@gmail.com") {
          Navigator.of(context).pushNamed('/dashboard',
              arguments: _user); //); // student version
        } else {
          Navigator.of(context)
              .pushNamed('/userdashboard', arguments: _user); //);
        }
      } else {
        displayToastMessage("Go register your account first.", context);
      }
    } on FirebaseAuthException catch (error) {
      displayToastMessage(
          "Error: " +
              error.toString() +
              " Or if this email is already registered, please check the spelling and try again.",
          context);
    }
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
