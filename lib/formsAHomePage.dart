import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'formsA.dart';
import 'formsADatabase.dart';
import 'formsAdd.dart';
import 'formsAList.dart';

class FormsAHomePage extends StatefulWidget {
  final FirebaseUser user;
  FormsAHomePage(this.user);
  @override
  _FormsAHomePageState createState() => _FormsAHomePageState();
}

class _FormsAHomePageState extends State<FormsAHomePage> {
  FirebaseUser user;
  List<FormsA> formsA = [];

  void newFormsA(String title, List<String> body, String url) {
    var formA = new FormsA(title, body, url);
    formA.setId(saveFormsA(formA));
    this.setState(() {
      formsA.add(formA);
    });
  }

  void updateFormsA() {
    getAllFormsA().then((formsA) => {
          this.setState(() {
            this.formsA = formsA;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateFormsA();
  }

  @override
  Widget build(BuildContext context) {
    return AcadsTInputWidget(this.newFormsA, this.user);
  }
}
/*
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello World!')),
        body: Column(children: <Widget>[
          Expanded(child: FormsAList(this.formsA, widget.user)),
          AcadsTInputWidget(this.newFormsA, this.user)
        ]));
  }
}
*/

class FormsAListPage extends StatefulWidget {
  final FirebaseUser user;
  FormsAListPage(this.user);
  @override
  _FormsAListPageState createState() => _FormsAListPageState();
}

class _FormsAListPageState extends State<FormsAListPage> {
  FirebaseUser user;
  List<FormsA> formsA = [];

  void newFormsA(String title, List<String> body, String url) {
    var formA = new FormsA(title, body, url);
    formA.setId(saveFormsA(formA));
    this.setState(() {
      formsA.add(formA);
    });
  }

  void updateFormsA() {
    getAllFormsA().then((formsA) => {
          this.setState(() {
            this.formsA = formsA;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateFormsA();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Academic Forms')),
        body: Column(children: <Widget>[
          Expanded(child: FormsAList()),
        ]));
  }
}
/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'formsA.dart';
import 'formsADatabase.dart';
import 'formsAdd.dart';
import 'formsAList.dart';

class FormsAHomePage extends StatefulWidget {
  final FirebaseUser user;
  FormsAHomePage(this.user);
  @override
  _FormsAHomePageState createState() => _FormsAHomePageState();
}

class _FormsAHomePageState extends State<FormsAHomePage> {
  FirebaseUser user;
  List<FormsA> formsA = [];

  void newFormsA(String title, List<String> body, String url) {
    var formA = new FormsA(title, body, url);
    formA.setId(saveFormsA(formA));
    this.setState(() {
      formsA.add(formA);
    });
  }

  void updateFormsA() {
    getAllFormsA().then((formsA) => {
          this.setState(() {
            this.formsA = formsA;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateFormsA();
  }

  @override
  Widget build(BuildContext context) {
    return AcadsTInputWidget(this.newFormsA, this.user);
  }
}
/*
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello World!')),
        body: Column(children: <Widget>[
          Expanded(child: FormsAList(this.formsA, widget.user)),
          AcadsTInputWidget(this.newFormsA, this.user)
        ]));
  }
}
*/

class FormsAListPage extends StatefulWidget {
  final FirebaseUser user;
  FormsAListPage(this.user);
  @override
  _FormsAListPageState createState() => _FormsAListPageState();
}

class _FormsAListPageState extends State<FormsAListPage> {
  FirebaseUser user;
  List<FormsA> formsA = [];

  void newFormsA(String title, List<String> body, String url) {
    var formA = new FormsA(title, body, url);
    formA.setId(saveFormsA(formA));
    this.setState(() {
      formsA.add(formA);
    });
  }

  void updateFormsA() {
    getAllFormsA().then((formsA) => {
          this.setState(() {
            this.formsA = formsA;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateFormsA();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Academic Forms')),
        body: Column(children: <Widget>[
          Expanded(child: FormsAList()),
        ]));
  }
}
*/
