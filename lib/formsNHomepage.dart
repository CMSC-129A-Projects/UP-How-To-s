import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'formsN.dart';
import 'formsNDatabase.dart';
import 'formsNInputWidget.dart';
import 'formsNList.dart';

class FormsNHomePage extends StatefulWidget {
  final FirebaseUser user;
  FormsNHomePage(this.user);
  @override
  _FormsNHomePageState createState() => _FormsNHomePageState();
}

class _FormsNHomePageState extends State<FormsNHomePage> {
  FirebaseUser user;
  List<FormsN> formsN = [];

  void newFormsN(String title, String body, String url) {
    var formN = new FormsN(title, body, url);
    formN.setId(saveFormsN(formN));
    this.setState(() {
      formsN.add(formN);
    });
  }

  void updateFormsN() {
    getAllFormsN().then((formsN) => {
          this.setState(() {
            this.formsN = formsN;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateFormsN();
  }

  @override
  Widget build(BuildContext context) {
    return NAcadsTInputWidget(this.newFormsN, this.user);
  }
}

class FormsNListPage extends StatefulWidget {
  final FirebaseUser user;
  FormsNListPage(this.user);
  @override
  _FormsNListPageState createState() => _FormsNListPageState();
}

class _FormsNListPageState extends State<FormsNListPage> {
  FirebaseUser user;
  List<FormsN> formsN = [];

  void newFormsN(String title, String body, String url) {
    var formN = new FormsN(title, body, url);
    formN.setId(saveFormsN(formN));
    this.setState(() {
      formsN.add(formN);
    });
  }

  void updateFormsN() {
    getAllFormsN().then((formsN) => {
          this.setState(() {
            this.formsN = formsN;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateFormsN();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Academic Forms')),
        body: Column(children: <Widget>[
          Expanded(child: FormsNList()),
        ]));
  }
}
