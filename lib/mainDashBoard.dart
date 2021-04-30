import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uphowtos1/formsAN.dart';
import 'formsAList.dart';
import 'package:uphowtos1/staffList.dart';
import 'mainDrawerDetails.dart';
import 'formsTwo.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON

class Dashboard extends StatefulWidget {
  final FirebaseUser user;
  Dashboard(this.user);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseUser user;
  Material myItems(String image, String heading, MaterialPageRoute route) {
    return Material(
      borderRadius: BorderRadius.circular(24.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, route);
        },
        child: Material(
          color: maroon,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                          fontSize: 15,
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
      drawer: DrawerDetails(),
      appBar: AppBar(
        centerTitle: true,
        title: Row(children: <Widget>[
          Image.network(
            'https://i.imgur.com/NdSHMGZ.png',
            height: 80,
            width: 80,
          ),
          Text(
            "UP\nHow To's",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
            ),
          ),
        ]),
        backgroundColor: maroon,
        elevation: 4.0,
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myItems('https://i.imgur.com/NdSHMGZ.png', "Forms",
              MaterialPageRoute(builder: (context) => FormsAList())),
          myItems('https://i.imgur.com/NdSHMGZ.png', "Staff List",
              MaterialPageRoute(builder: (context) => FormsAList())),
          myItems('https://i.imgur.com/NdSHMGZ.png', "Discussion Board",
              MaterialPageRoute(builder: (context) => FormsList())),
          myItems('https://i.imgur.com/NdSHMGZ.png', "Organization Board",
              MaterialPageRoute(builder: (context) => HomePage(user))),
          myItems('https://i.imgur.com/NdSHMGZ.png', "UPC Map",
              MaterialPageRoute(builder: (context) => HomePage(user))),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
        ],
      ),
    );
  }
}
