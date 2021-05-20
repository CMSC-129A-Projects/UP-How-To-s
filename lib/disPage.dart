import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';
import 'package:uphowtos1/pseudoUser.dart';
import 'package:uphowtos1/copy.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController dscrptnCtrl = TextEditingController();
  User testUser = User(name: "James", key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return _widgetBody(context);
  }

  SafeArea _widgetBody(BuildContext context) {
    final discussion = context.watch<DiscussionList>();
    return SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: _body(context, discussion),
        ),
      );
  }
  AppBar _appBar() => AppBar(
      title: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:10.0),
            child: Text(
              "Discussion Board",
              style: TextStyle(
                fontFamily: 'Helvetica',
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0,),
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: _searchTab(),
        ),
      ),
    );

  Container _searchTab() => Container(
      child: TextFormField(
        controller: searchCtrl,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0),),
            gapPadding: 0,
          ),
          hintText: "Search",
          hintStyle: TextStyle(
            fontFamily: 'Helvetica'
          ),
          prefixIcon: Icon(
            Icons.search, 
            color: Colors.grey.shade300,
          ),
        ),
      )
    );

  Widget _body(BuildContext context, DiscussionList discussion) => Container(
    width: double.infinity,
    margin: EdgeInsets.all(10.0),
    color: Colors.cyan,
    child: Column(
      children: <Widget> [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          margin: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
            color: maroon,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey, 
                blurRadius: 6, 
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                margin: EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: titleCtrl,
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: InputBorder.none, 
                        isDense: true,
                      ),
                    ),
                    Divider(),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: dscrptnCtrl,
                      decoration: InputDecoration(
                        hintText: "What is it about?",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      // backgroundColor: Colors.pink.shade900,
                    ),
                    onPressed: ()=>{},
                    child: Text(
                      "Post",
                      style: TextStyle(
                        fontFamily: 'Helvetica-Bold',
                        fontSize: 15,
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ]
    )
  );
}