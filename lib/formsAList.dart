import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'formsA.dart';

class FormsAList extends StatefulWidget {
  final List<FormsA> listItems;
  final FirebaseUser user;

  FormsAList(this.listItems, this.user);

  @override
  _FormsAListState createState() => _FormsAListState();
}

class _FormsAListState extends State<FormsAList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          )),
          Row(children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(Icons.file_download),
                  tooltip: 'Copy the hyperlink.',
                  onPressed: () {
                    Text(post.url);
                  }),
            )
          ])
        ]));
      },
    );
  }
}
