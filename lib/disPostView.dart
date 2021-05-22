import 'package:flutter/material.dart';
import 'package:uphowtos1/disBlockData.dart';

class DiscussionPostView extends StatefulWidget {
  final DiscussionBlock data;
  const DiscussionPostView({this.data, Key key}): super(key: key);

  @override
  _DiscussionPostViewState createState() => _DiscussionPostViewState();
}

class _DiscussionPostViewState extends State<DiscussionPostView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
      )
    );
  }

  Widget _body() => Column(
    children: <Widget> [
      _customAppBar(),
    ],
  );

  Container _customAppBar() {
    return Container(
      width: double.infinity,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () => {Navigator.pop(context)},  
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => {}
          ),
        ],
      ),
    );
  }
}