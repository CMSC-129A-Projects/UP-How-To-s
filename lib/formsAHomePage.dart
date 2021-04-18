import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'formsA.dart';
import 'formsADatabase.dart';
import 'formsAInputWidget.dart';

class FormsAHomePage extends StatefulWidget {
  @override
  _FormsAHomePageState createState() => _FormsAHomePageState();
}

class _FormsAHomePageState extends State<FormsAHomePage> {
  List<FormsA> formsA = [];

  void newFormsA(String title, String body, String url) {
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
    return AcadsTInputWidget(this.newFormsA);
  }
}
