import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'formsNList.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack
final gradientcolor1 = const Color(0xFF7b4397); // UP YELLOW
final gradientcolor2 = const Color(0xFFdc2430); // UP Spotblack

class EditFormsN extends StatefulWidget {
  String contactKey;

  EditFormsN({this.contactKey});

  @override
  _EditFormsNState createState() => _EditFormsNState();
}

class _EditFormsNState extends State<EditFormsN> {
  TextEditingController _title, _body, _url;
  DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _body = TextEditingController();
    _url = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('formsN');
    getFormsDetail();
  }

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
              TextField(
                controller: _title,
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
                controller: _body,
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
                controller: _url,
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
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    saveForms();
                  },
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
                                FormsNList())); //go to forms page
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

  getFormsDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();

    Map contact = snapshot.value;

    _title.text = contact['title'];
    _body.text = contact['body'];
    _url.text = contact['url'];
  }

  void saveForms() {
    String title = _title.text;
    String body = _body.text;
    String url = _url.text;
    Map<String, String> contact = {
      'title': title,
      'body': body,
      'url': url,
    };

    _ref.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }
}
