/*import 'package:flutter/material.dart';
import 'mainnewLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
  bool authCheck = false;
  double spc = 15;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    emailInput(),
                    spacing(0, spc),
                    passwordInput(),
                  ])))),
    ));
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
              child: Text('I will use my UP mail upon creating an account',
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
              if(passController.text.length < 7){
              displayToastMessage("password must be greater than 7 characters",context);

              }
              else if(!emailController.text.contains("@")){
                displayToastMessage("Invalid Password",context);
              }
              else{
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
  void registerNewUser(BuildContext context){
    final User user = (await_firebaseAuth.createUserWithEmailAndPassword(email:emailController.text,password:passController.text)).user;
    if(user!=NULL){
      Map userDataMap{
        "email" = emailController.text.trim();
        "password" = passController.text.trim();
      }
      usersRef.child(user.uid).set(userDataMap);
    }
    else{

    }

  }

  displayToastMessage(string Message, BuildContext context){
    FlutterToast.showToast(msg:Message);
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

}*/
