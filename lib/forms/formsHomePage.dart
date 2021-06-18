import 'package:flutter/material.dart';
import 'package:uphowtos1/colors_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'forms.dart';
import 'formsDatabase.dart';
import 'formsAdd.dart';

class FormsHomePage extends StatefulWidget {
  FormsHomePage();
  @override
  _FormsHomePageState createState() => _FormsHomePageState();
}

class _FormsHomePageState extends State<FormsHomePage> {
  User cuser;
  List<Forms> forms = [];

  void newForm(String title, List<String> body, String url, String desc) {
    var form = new Forms(title, body, url, desc);
    form.setId(saveForms(form));
    this.setState(() {
      forms.add(form);
    });
  }

  void updateForms() {
    getAllForms().then((forms) => {
          this.setState(() {
            this.forms = forms;
          })
        });
  }

  //FOR DISPLAYING DATA
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('forms');

  //FOR THE SEARCHTAB
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory;
  String selectedTerm;
  FloatingSearchBarController controller;

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
    updateForms();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
    final FirebaseAuth auth = FirebaseAuth.instance;
    cuser = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 2.0),
              blurRadius: 4.0,
            )
          ]),
          child: AppBar(
            shadowColor: Colors.grey,
            elevation: 12.0,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Add New Form",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Helvetica',
                  ),
                ),
                if (cuser.email == "uphowtosofc@gmail.com")
                  Text(
                    'Administrator Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
            actions: [
              if (cuser.email == "uphowtosofc@gmail.com")
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormsInputWidget(newForm)));
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
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
            backgroundColor: maroon,
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultListView(
            cuser,
            searchTerm: selectedTerm,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? 'Search',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search Form Title',
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
                        'Search  Form Title',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
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
      ),
    );
  }
}

class SearchResultListView extends StatelessWidget {
  final String searchTerm;
  final User cuser;
  SearchResultListView(
    this.cuser, {
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  _showDeleteDialog(context, {Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete this form?'),
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
                      FirebaseDatabase.instance.reference().child('forms');
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

  Widget _buildContactItem(BuildContext context, {Map contact}) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed('/formsview', arguments: contact); //adm
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
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Helvetica-Bold',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      contact['desc'],
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Helvetica',
                        color: Colors.grey[850],
                      ),
                    ),
                    SizedBox(height: 2.0),
                  ]),
            ),
            if (cuser.email == "uphowtosofc@gmail.com")
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
                        Navigator.of(context).pushNamed(
                          '/formsedit',
                          arguments: contact['key'],
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
        ));
  }

  Widget _buildEmpty({Map contact}) {
    return Container(
        //very important FILLER BUILDER to not have weird spaces in between tiles
        );
  }

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      Query _ref = FirebaseDatabase.instance
          .reference()
          .child('forms')
          .orderByChild('title');
      return Container(
        margin: EdgeInsets.only(top: 60.0),
        width: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;
            return _buildContactItem(context, contact: contact);
          },
        ),
      );
    }

    Query dsds = FirebaseDatabase.instance
        .reference()
        .child('forms')
        .orderByChild("title")
        .equalTo(searchTerm);
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      width: double.infinity,
      child: FirebaseAnimatedList(
        query: dsds,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map contact = snapshot.value;
          contact['key'] = snapshot.key;
          String small = contact["title"].toLowerCase();
          String smaller = searchTerm.toLowerCase();
          if (small.contains(smaller))
            return _buildContactItem(context, contact: contact);
          else
            return _buildEmpty(contact: contact);
        },
      ),
    );
  }
}
