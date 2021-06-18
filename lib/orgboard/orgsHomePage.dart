import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'orgs.dart';
import 'orgsDatabase.dart';
import 'orgsAdd.dart';
import 'orgsList.dart';

class OrgsHomePage extends StatefulWidget {
  final User user;
  OrgsHomePage(this.user);
  @override
  _OrgsHomePageState createState() => _OrgsHomePageState();
}

class _OrgsHomePageState extends State<OrgsHomePage> {
  User user;
  List<Orgs> orgs = [];

  void newOrgs(
      String title, List<String> officers, String contactinfo, String desc) {
    var org = new Orgs(title, officers, contactinfo, desc);
    org.setId(saveOrgs(org));
    this.setState(() {
      orgs.add(org);
    });
  }

  void updateOrgs() {
    getAllOrgs().then((orgs) => {
          this.setState(() {
            this.orgs = orgs;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateOrgs();
  }

  @override
  Widget build(BuildContext context) {
    return OrgsInputWidget(this.newOrgs);
  }
}

class OrgsListPage extends StatefulWidget {
  final User user;
  OrgsListPage(this.user);
  @override
  _OrgsListPageState createState() => _OrgsListPageState();
}

class _OrgsListPageState extends State<OrgsListPage> {
  User user;
  List<Orgs> orgs = [];

  void newOrgs(
      String name, List<String> officers, String contactinfo, String desc) {
    var org = new Orgs(name, officers, contactinfo, desc);
    org.setId(saveOrgs(org));
    this.setState(() {
      orgs.add(org);
    });
  }

  void updateOrgs() {
    getAllOrgs().then((orgs) => {
          this.setState(() {
            this.orgs = orgs;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateOrgs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Organizations')),
        body: Column(children: <Widget>[
          Expanded(child: OrgsList()),
        ]));
  }
}





/*import 'package:flutter/material.dart';
import 'package:uphowtos1/colors_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'orgs.dart';
import 'orgsDatabase.dart';
import 'orgsAdd.dart';

class OrgsHomePage extends StatefulWidget {
  OrgsHomePage();
  @override
  _OrgsHomePageState createState() => _OrgsHomePageState();
}

class _OrgsHomePageState extends State<OrgsHomePage> {
  User cuser;
  List<Orgs> orgs = [];

  void newOrgs(
      String name, List<String> officers, String contactinfo, String desc) {
    var org = new Orgs(name, officers, contactinfo, desc);
    org.setId(saveOrgs(org));
    this.setState(() {
      orgs.add(org);
    });
  }

  void updateOrgs() {
    getAllOrgs().then((orgs) => {
          this.setState(() {
            this.orgs = orgs;
          })
        });
  }

  //FOR DISPLAYING DATA
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('orgs');

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
    updateOrgs();
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
                  "Add New Org",
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
                              builder: (context) => OrgsInputWidget(newOrgs)));
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
        hint: 'Search Org Name',
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
                        'Search Org Name',
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
            title: Text('Delete this org record?'),
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
        Navigator.of(context).pushNamed('/orgsview', arguments: contact);
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
                    contact['name'],
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
                        '/orgsedit',
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
      ),
    );
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
          .child('orgs')
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
        .child('orgs')
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

class ViewOrgs extends StatelessWidget {
  final Map contact;
  ViewOrgs({
    Key key,
    @required this.contact,
  }) : super(key: key);
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
                  "Organizations",
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
              backgroundColor: green,
            ),
          ),
          preferredSize: Size.fromHeight(60.0),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                            child: Row(
                              // mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Flexible(
                                Center(
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/seed/658/600',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  contact["name"],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    contact['desc'],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    color: green,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Contact Information',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  contact["contactinfo"],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    color: green,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(30),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Officers',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  ..._getSteps(contact["officers"]),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

List<Widget> _getSteps(List steps) {
  List<Widget> stepsTextFields = [];
  for (int i = 0; i < steps.length; i++) {
    if (steps[i] != null) {
      stepsTextFields.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                steps[i],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      );
    }
  }
  return stepsTextFields;
}
*/