import 'package:flutter/material.dart';
import 'formsNHomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class NAcadsTInputWidget extends StatefulWidget {
  final Function(String, String, String) callback;
  NAcadsTInputWidget(this.callback, this.user);

  final FirebaseUser user;

  @override
  _NAcadsTInputWidgetState createState() => _NAcadsTInputWidgetState();
}

class _NAcadsTInputWidgetState extends State<NAcadsTInputWidget> {
  FirebaseUser user;
  final title = TextEditingController();
  final body = TextEditingController();
  final url = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    title.dispose();
    body.dispose();
    url.dispose();
  }

  void click() {
    widget.callback(title.text, body.text, url.text);
    FocusScope.of(context).unfocus();
    title.clear();
    body.clear();
    url.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Forms'),
          centerTitle: true,
          backgroundColor: maroon,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: this.title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Form Name',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: this.body,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Steps Here',
                ),
                maxLines: null,
              ),
              SizedBox(height: 15),
              TextField(
                controller: this.url,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: maroon),
                  ),
                  labelStyle: TextStyle(color: maroon),
                  labelText: 'Enter Form Hyperlink Here',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: this.click,
                  child: Text('Add Form'),
                  style: ElevatedButton.styleFrom(
                      primary: maroon,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FormsNListPage(user))); //go to forms page
                  },
                  child: Text('Check Forms'),
                  style: ElevatedButton.styleFrom(
                      primary: maroon,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ));
  }
}
