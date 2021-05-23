import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'orgs.dart';
import 'orgsDatabase.dart';
import 'orgsAdd.dart';
import 'orgsList.dart';

class OrgsHomePage extends StatefulWidget {
  final User user;
  OrgsHomePage(this.user);
  @override
  _OrgsHomePageState createState() => _OrgsHomePageState();
}

class _OrgsHomePageState extends State<OrgsHomePage> {
  User user;
  List<Orgs> orgs = [];

  void newOrgs(
      String title, List<String> officers, String contactinfo, String desc) {
    var org = new Orgs(title, officers, contactinfo, desc);
    org.setId(saveOrgs(org));
    this.setState(() {
      orgs.add(org);
    });
  }

  void updateOrgs() {
    getAllOrgs().then((orgs) => {
          this.setState(() {
            this.orgs = orgs;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateOrgs();
  }

  @override
  Widget build(BuildContext context) {
    return OrgsInputWidget(this.newOrgs, this.user);
  }
}

class OrgsListPage extends StatefulWidget {
  final User user;
  OrgsListPage(this.user);
  @override
  _OrgsListPageState createState() => _OrgsListPageState();
}

class _OrgsListPageState extends State<OrgsListPage> {
  User user;
  List<Orgs> orgs = [];

  void newOrgs(
      String name, List<String> officers, String contactinfo, String desc) {
    var org = new Orgs(name, officers, contactinfo, desc);
    org.setId(saveOrgs(org));
    this.setState(() {
      orgs.add(org);
    });
  }

  void updateOrgs() {
    getAllOrgs().then((orgs) => {
          this.setState(() {
            this.orgs = orgs;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateOrgs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Organizations')),
        body: Column(children: <Widget>[
          Expanded(child: OrgsList()),
        ]));
  }
}
