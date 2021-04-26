import 'package:flutter/material.dart';
import 'package:uphowtos1/screens/LogIn/LoginPage.dart';
import 'package:uphowtos1/mainLogIn.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  bool authCheck = false;
  double spc = 15;

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
                    spacing(0, spc),
                    authorizationCheck(),
                    spacing(spc,0)
                  ])))),
    ));
  }

  Widget authorizationCheck() => Row(
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
              'I will use my UP mail upon creating an account',
              style: TextStyle(
                  fontSize: 18, 
                  fontFamily: 'Helvetica-Light'
              )
            ),
        )
        ],
      );

  Widget spacing(double x, double y) => SizedBox(
        height: y,
        width: x,
      );
}
