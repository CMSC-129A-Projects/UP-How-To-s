import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON

class FormsAdmin extends StatefulWidget {
  @override
  _FormsAdminState createState() => _FormsAdminState();
}

class _FormsAdminState extends State<FormsAdmin> {
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory;
  String selectedTerm;

  List<String> filterSearchTerms(
    {
      @required String filter,
    }
  ){
    if (filter != null && filter.isNotEmpty){
      return _searchHistory.reversed
      .where((term) => term.startsWith(filter))
      .toList();
    }
    else{
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term){
    if (_searchHistory.contains(term)){
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength){
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term){
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term){
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController controller;

  @override
  void initState(){
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Forms',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Helvetica',
              ),
            ),
            Text(
              'Administrator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
        backgroundColor: maroon,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              final snackBar = SnackBar(content: Text('Go To AddForms'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, //insert go to addforms here
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          color: Colors.white,
          onPressed: () {
            final snackBar = SnackBar(content: Text('Side-thingy'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
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
        onQueryChanged: (query){
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query){
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition){
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context){
                  if (filteredSearchHistory.isEmpty &&
                  controller.query.isEmpty){
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
                  }
                  else if (filteredSearchHistory.isEmpty) {
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
                  }
                  else{
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory.map(
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

  const SearchResultListView({
    Key key,
    @required this.searchTerm,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null){
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Search the Form Name',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return ListView(
      padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
      children: List.generate(
        50,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        )
      ),
    ); //This will be edited to get the firebase, but for now this is a dummy search result
  }
}