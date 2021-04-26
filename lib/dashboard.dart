import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uphowtos1/staffList.dart';
import 'mainDrawerDetails.dart';
import 'formsTwo.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON

class Dashboard extends StatefulWidget {
  final FirebaseUser user;
  Dashboard(this.user);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseUser user;
  Material myItems(String image, String heading) {
    return Material(
      borderRadius: BorderRadius.circular(24.0),
      child: GestureDetector(
        onTap: () {
          final snackBar = SnackBar(content: Text(heading));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          color: Colors.white,
          onPressed: () {
            final snackBar = SnackBar(content: Text("Side-thingy"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myItems('https://i.imgur.com/NdSHMGZ.png', "Forms"),
          myItems('https://i.imgur.com/NdSHMGZ.png', "Staff List"),
          myItems('https://i.imgur.com/NdSHMGZ.png', "Discussion Board"),
          myItems('https://i.imgur.com/NdSHMGZ.png', "Organization Board"),
          myItems('https://i.imgur.com/NdSHMGZ.png', "UPC Map"),
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
