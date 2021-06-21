import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uphowtos1/discboard/pnPostView.dart';
import 'postDatabase.dart';
import 'post.dart';
import 'postAdd.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:uphowtos1/colors_fonts.dart';

class NewPostHomePage extends StatefulWidget {
  final User user;

  NewPostHomePage(this.user);

  @override
  _NewPostHomePageState createState() => _NewPostHomePageState();
}

class _NewPostHomePageState extends State<NewPostHomePage> {
  List<Post> posts = [];

  void newPost(String nickname, String author, String body, String date,
      bool edit, String keywords, String title, int likenum, int flagnum) {
    var post =
        new Post(nickname, author, body, date, edit, keywords, title, 0, 0);
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
    });
  }

  void updatePosts() {
    getAllPosts().then((posts) => {
          this.setState(() {
            this.posts = posts;
          })
        });
  }

  //FOR THE SEARCHTAB
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory;
  String selectedTerm;
  FloatingSearchBarController controller;
  // @override

  //FOR DISPLAYING DATA
  Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('posts');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<String> filterSearchTerms({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('posts')
        .orderByChild('title');

    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _fSearchBar(),
    );
  }

  FloatingSearchBar _fSearchBar() {
    return FloatingSearchBar(
      automaticallyImplyBackButton: false,
      controller: controller,
      body: FloatingSearchBarScrollNotifier(
        child: SearchResultListView(
          this.posts,
          searchTerm: selectedTerm,
        ),
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      title: Text(
        //  TODO: title will not exist after searching an empty string, since the string will transform into an empty string rather than having a null value
        selectedTerm ?? 'Search Post',
        style: subHeader02(Colors.grey.shade500),
      ),
      hint: 'Search Post',
      hintStyle: subHeader02(Colors.grey.shade500),
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      onQueryChanged: (query) {
        setState(() {
          filteredSearchHistory = filterSearchTerms(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          addSearchTerm(query);
          selectedTerm = query;
        });
        controller.close();
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Builder(
              builder: (context) {
                if (filteredSearchHistory.isEmpty &&
                    controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Search Post',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: bodyText(Colors.black87),
                    ),
                  );
                } else if (filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(controller.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        addSearchTerm(controller.query);
                        selectedTerm = controller.query;
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTermFirst(term);
                                selectedTerm = term;
                              });
                              controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          elevation: 12.0,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Discussion Board",
                style: pageTitle(Colors.white),
              ),
              Text(
                'Administrator Mode',
                style: pageSubTitle(Colors.white),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostsInputWidget(newPost),
                      ),
                  );
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30.0,
                ),
                splashRadius: 24.0,
                tooltip: 'Add post',
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          backgroundColor: green,
        ),
      ),
      preferredSize: Size.fromHeight(60.0),
    );
  }
}

class SearchResultListView extends StatelessWidget {
  final String searchTerm;
  final List<Post> posts;


  SearchResultListView(
    this.posts, {
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  _showDeleteDialog(context, {Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['title']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                style: ElevatedButton.styleFrom(primary: maroon),
              ),
              ElevatedButton(
                onPressed: () {
                  DatabaseReference reference =
                      FirebaseDatabase.instance.reference().child('posts');
                  reference
                      .child(contact['key'])
                      .remove()
                      .whenComplete(() => Navigator.pop(context));
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(primary: maroon),
              )
            ],
          );
        });
  }

  Widget _buildContactItem(post, context, {Map contact}) {
    return InkWell(
      onTap: () {
        //Navigator.of(context).pushNamed('/postview');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ViewPostNew(
                      post,
                      contact,
                      contactKey: contact['key'],
                ),
            ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 6, offset: Offset(0, 4)),
            ]),
        child: Row(children: <Widget>[
          Expanded(
            flex: 8,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    contact['title'],
                    style: header02(maroon),
                  ),
                  Text(
                    contact['keywords'],
                    style: subHeader01(Colors.grey[850]),
                  ),
                ]),
          ),
          Expanded(
            flex: 1,
            child: PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              onSelected: (item) {
                switch (item) {
                  case 0:
                    //Edit Item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostsInputWidget.toEdit(
                          contact
                        ),
                      ),
                    );
                    break;
                  case 1:
                    //Remove Item
                    _showDeleteDialog(context, contact: contact);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('Edit'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('Remove'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
        //very important, makes us dodge errors hahahah
        ///FILLER BUILDER
        );
  }

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      Query _ref = FirebaseDatabase.instance
          .reference()
          .child('posts')
          .orderByChild('title');
      return Container(
        margin: EdgeInsets.only(top: 60.0),
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;

            return _buildContactItem(this.posts[index], context,
                contact: contact);
          },
        ),
      );
    }

    Query _ref = FirebaseDatabase.instance
        .reference()
        .child('posts')
        .orderByChild("keywords")
        .equalTo(searchTerm);
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map contact = snapshot.value;
          contact['key'] = snapshot.key;
          //return _buildContactItem(context,contact: contact);
          String small = contact["keywords"].toLowerCase();
          String smaller = searchTerm.toLowerCase();
          if (small.contains(smaller)) {
            return _buildContactItem(this.posts[index], context,
                contact: contact);
          } else
            return _buildEmpty();
        },
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  final Function(String, String, String, String, bool, String, String, int, int)
      callback;

  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  String nickname;
  User user;
  String author;
  String body;
  String date;
  bool edit;
  String title;
  String keywords;
  String usersLiked;
  String usersFlagged;
  int likenum;
  int flagnum;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(
        nickname, author, body, date, edit, keywords, title, likenum, flagnum);
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: "Type a message:",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue,
              tooltip: "Post message",
              onPressed: this.click,
            ),),);
  }
}
