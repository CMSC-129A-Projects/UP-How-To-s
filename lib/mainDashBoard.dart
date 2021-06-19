import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class Dashboard extends StatefulWidget {
  Dashboard();
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User user;
  Material myItems(
      String image, String heading, String desc, int sasa, String route) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(15.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(children: <Widget>[
                      if (sasa == 1)
                        Icon(
                          Icons.file_copy,
                          color: maroon,
                          size: 55,
                        ),
                      if (sasa == 2)
                        Icon(
                          Icons.person_search,
                          color: maroon,
                          size: 55,
                        ),
                      if (sasa == 3)
                        Icon(
                          Icons.forum,
                          color: green,
                          size: 55,
                        ),
                      if (sasa == 4)
                        Icon(
                          Icons.group,
                          color: green,
                          size: 55,
                        ),
                      if (sasa == 5)
                        Icon(
                          Icons.account_circle_rounded,
                          color: yellow,
                          size: 55,
                        ),
                      Text(
                        heading,
                        style: TextStyle(
                          color: spotblack,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              automaticallyImplyLeading: false,
              shadowColor: Colors.grey,
              elevation: 12.0,
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "UP How to's",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Helvetica-Bold',
                    ),
                  ),
                  Text(
                    'Administrator Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
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
        body: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            children: <Widget>[
              myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Forms & Processes",
                "Find formats and guides for academic and non academic forms here.",
                1,
                "/forms",
              ),
              myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Discussion Board",
                "Got questionds? See our discussion board for answers and more!",
                3,
                "/post",
              ),
              myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Personnel Directory",
                "Get to know our very own UPC people here.",
                2,
                "/staff",
              ),
              myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Organization Board",
                "Check out existing organizations and what they have in store!",
                4,
                "/orgs",
              ),
              myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "User Profile",
                "Manage your account and past posts.",
                5,
                "/prof",
              )
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
            ],
          ),
        ),
      ),
    );
  }
}
