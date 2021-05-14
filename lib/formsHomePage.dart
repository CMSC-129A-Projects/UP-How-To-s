import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forms.dart';
import 'formsDatabase.dart';
import 'formsAdd.dart';
import 'formsList.dart';

class FormsHomePage extends StatefulWidget {
  final FirebaseUser user;
  FormsHomePage(this.user);
  @override
  _FormsHomePageState createState() => _FormsHomePageState();
}

class _FormsHomePageState extends State<FormsHomePage> {
  FirebaseUser user;
  List<Forms> forms = [];

  void newForms(String title, List<String> body, String url, String desc) {
    var form = new Forms(title, body, url, desc);
    form.setId(saveForms(form));
    this.setState(() {
      forms.add(form);
    });
  }

  void updateForms() {
    getAllForms().then((forms) => {
          this.setState(() {
            this.forms = forms;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateForms();
  }

  @override
  Widget build(BuildContext context) {
    return AcadsTInputWidget(this.newForms, this.user);
  }
}

class FormsListPage extends StatefulWidget {
  final FirebaseUser user;
  FormsListPage(this.user);
  @override
  _FormsListPageState createState() => _FormsListPageState();
}

class _FormsListPageState extends State<FormsListPage> {
  FirebaseUser user;
  List<Forms> forms = [];

  void newForms(String title, List<String> body, String url, String desc) {
    var form = new Forms(title, body, url, desc);
    form.setId(saveForms(form));
    this.setState(() {
      forms.add(form);
    });
  }

  void updateForms() {
    getAllForms().then((forms) => {
          this.setState(() {
            this.forms = forms;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateForms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Academic Forms')),
        body: Column(children: <Widget>[
          Expanded(child: FormsList()),
        ]));
  }
}
