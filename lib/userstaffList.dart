import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class UserStaffList extends StatefulWidget {
  UserStaffList();
  @override
  _UserStaffListState createState() => _UserStaffListState();
}

class _UserStaffListState extends State<UserStaffList> {
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory;
  String selectedTerm;
  FloatingSearchBarController controller;
  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Personnel Directory",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Helvetica',
                ),
              ),
            ),
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
            searchTerm: selectedTerm,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? 'Search',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search the Form Name',
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
                        'Search the Form Name',
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

  SearchResultListView({
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  _showStaffInfo(context, {Map contact}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            scrollable: true,
            elevation: 6.0,
            backgroundColor: Colors.white,
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Staff Information',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Helvetica-Bold',
                      color: maroon,
                    ),
                  ),
                ]),
            content: Column(
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: maroon,
                  ),
                ),
                Text(
                  contact['name'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica',
                    color: spotblack,
                  ),
                ),
                Text(
                  'Department: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: maroon,
                  ),
                ),
                Text(
                  contact['department'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica',
                    color: spotblack,
                  ),
                ),
                Text(
                  'Position: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: maroon,
                  ),
                ),
                Text(
                  contact['position'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica',
                    color: spotblack,
                  ),
                ),
                Text(
                  'Office Location: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: maroon,
                  ),
                ),
                Text(
                  contact['location'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica',
                    color: spotblack,
                  ),
                ),
                Text(
                  'UP Email: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica-Bold',
                    color: maroon,
                  ),
                ),
                Text(
                  contact['email'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Helvetica',
                    color: spotblack,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildContactItem(BuildContext context, {Map contact}) {
    return InkWell(
      onTap: () {
        _showStaffInfo(context, contact: contact);
      },
      child: Container(
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
                    contact['name'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Helvetica-Bold',
                      color: maroon,
                    ),
                  ),
                  Text(
                    contact['department'],
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Helvetica',
                      color: Colors.grey[850],
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    contact['position'],
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Helvetica',
                      color: Colors.grey[850],
                    ),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildEmpty({Map contact}) {
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
          .child('staff')
          .orderByChild('name');
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
        .child('staff')
        .orderByChild("name")
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
          String small = contact["name"].toLowerCase();
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
