import 'package:flutter/material.dart';
import 'formsADatabase.dart';
import 'formsAHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'formsA.dart';
import 'formsAList.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class FormsList extends StatefulWidget {
  @override
  FormsListState createState() => FormsListState();
}

class FormsListState extends State<FormsList> {
  List<Widget> _formTiles = [];
  final GlobalKey _listKey = GlobalKey();
  List<FormsA> _forms;
  @override
  void initState() {
    super.initState();
    _addForms();
  }

  void _addForms() {
    _forms = [
      /*
      Form(
          formName: 'Form 5A',
          formDetails: 'Form given after enrollment',
          img: ''),
      Form(
          formName: 'Dropping Form',
          formDetails: 'Form for dropping a subject',
          img: ''),*/
    ];

    _forms.forEach((FormsA form) {
      _formTiles.add(_buildTile(form));
    });
  }
/*
  void _removeForm(Form A) {
    _forms.remove(A);
  }*/

  Widget _buildTile(FormsA form) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(5),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(form.title, style: TextStyle(fontSize: 20, color: maroon)),
          Text('${form.body}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.download_sharp,
          color: Colors.grey[400],
          size: 30,
        ),
        onPressed: () {},
      ),
      leading: IconButton(
        icon: Icon(
          Icons.account_balance_sharp,
          color: Colors.grey[400],
          size: 30,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _listKey,
        itemCount: _formTiles.length,
        itemBuilder: (context, index) {
          return _formTiles[index];
        });
  }
}

class AcadsFormsPage extends StatefulWidget {
  final FirebaseUser user;
  AcadsFormsPage(this.user);
  @override
  AcadsFormsPageState createState() => AcadsFormsPageState();
}

class AcadsFormsPageState extends State<AcadsFormsPage> {
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
        backgroundColor: Colors.blueGrey[50],
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bGlicmFyeXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                SizedBox(
                  height: 160,
                  child: Text(
                    'Academic Forms',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: FormsList())
              ],
            )));
  }
}

class FormsActions extends StatefulWidget {
  final FirebaseUser user;
  FormsActions(this.user);
  @override
  FormsActionsState createState() => FormsActionsState();
}

class FormsActionsState extends State<FormsActions> {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Forms'),
          centerTitle: true,
          backgroundColor: maroon,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 50),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1593672572837-d1bb82b59370?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=967&q=80',
                      ),
                      child: InkWell(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FormsAHomePage(user))); //go to forms page
                      }),
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Add Forms',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1574629173115-01ba37282238?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=711&q=80',
                      ),
                      child: InkWell(
                        onTap: () {},
                      ),
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Edit Forms',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1599183954724-84005c744c28?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
                      ),
                      child: InkWell(
                        onTap: () {},
                      ),
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Remove Forms',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class NonFormsPage extends StatefulWidget {
  final FirebaseUser user;
  NonFormsPage(this.user);
  @override
  NonFormsPageState createState() => NonFormsPageState();
}

class NonFormsPageState extends State<NonFormsPage> {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FormsActions(user))); //g
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: Text('Update Forms'),
          foregroundColor: Colors.orange,
          backgroundColor: maroon,
        ),
        backgroundColor: Colors.blueGrey[50],
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bGlicmFyeXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                SizedBox(
                  height: 160,
                  child: Text(
                    'Non-Academic Forms',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: FormsList(),
                )
              ],
            )));
  }
}
