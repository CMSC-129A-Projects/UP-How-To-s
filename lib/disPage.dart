import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/disList.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new DiscussionList(),
      child: _body(),
    );
  }

  SafeArea _body() => SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(),
            ],
          ),
        ),
      );
}
