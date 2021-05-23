import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

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
  bool hasSubmitted = false;
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
            errorText: 'Wrong password. Try Again',
            suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () =>
                    setState(() => isPasswordVisible = !isPasswordVisible))),
        keyboardType: TextInputType.visiblePassword,
        obscureText: isPasswordVisible,
      );

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
              print("dsdsdsdsdsdsdsssssssssssssssssssssssssssssssssssssssssss");
              loginAndAunthenticate(context);
              print("yoahit");
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
    print("yoooo88");

    final User user = (await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text))
        .user;
    print(emailController.text);
    print(passController.text);
    if (user != null) {
      usersRef.child(user.uid).once().then((DataSnapshot snap) {
        print("yoooo");
        if (snap.value != null) {
          print(
              "=================================================================");
          Navigator.of(context)
              .pushNamed('/dashboard', arguments: user); //); // student version
        }
      });
      print("yoooossss");
      //Navigator.of(context).pushNamed('/dashboard', arguments: user);
    } else {
      auth.signOut();
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
