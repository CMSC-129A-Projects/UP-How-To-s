import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'formsList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'staffList.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
final green = const Color(0xFF228b22); // UP GREEN
final yellow = const Color(0xFFFFB81C); // UP YELLOW
final spotblack = const Color(0xFF000000); // UP Spotblack

class Dashboard extends StatefulWidget {
  final FirebaseUser user;
  Dashboard(this.user);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseUser user;
  Material myItems(
      String image, String heading, String desc, MaterialPageRoute route) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, route);
        },
        child: Material(
          color: maroon,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(15.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Image.network(
                        image,
                        height: 80,
                        width: 80,
                      ),
                      Text(
                        heading,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        desc,
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
            automaticallyImplyLeading: false,
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
        padding: EdgeInsets.only(top: 12.0),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          children: <Widget>[
            myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Forms",
                "Find formats and guides for academic and non academic forms here.",
                MaterialPageRoute(builder: (context) => FormsList())),
            myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Personnel Directory",
                "Get to know our very own UPC people.",
                MaterialPageRoute(builder: (context) => StaffList())),
            myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Discussion Board",
                "Got questionds? See our discussion board for answers and more!",
                MaterialPageRoute(builder: (context) => FormsList())),
            myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "Organization Board",
                "Check out existing organizations and what they have in store!",
                MaterialPageRoute(builder: (context) => FormsList())),
            myItems(
                'https://i.imgur.com/NdSHMGZ.png',
                "User Profile",
                "Manage your account and past posts.",
                MaterialPageRoute(builder: (context) => FormsList())),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 150.0),
            StaggeredTile.extent(1, 150.0),
            StaggeredTile.extent(1, 150.0),
            StaggeredTile.extent(1, 150.0),
            StaggeredTile.extent(1, 150.0),
          ],
        ),
      ),
    );
  }
}
