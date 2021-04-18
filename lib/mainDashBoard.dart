import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainDrawerDetails.dart';
import 'formsTwo.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON

class GridDashBoard extends StatefulWidget {
  final FirebaseUser user;
  GridDashBoard(this.user);
  @override
  GridDashboardState createState() => new GridDashboardState();
}

class GridDashboardState extends State<GridDashBoard> {
  FirebaseUser user;
  int x = 0;
  Items item1 = new Items(
      title: "Forms",
      subtitle: "Academic and Non-Academic",
      event: "",
      img: "assets/Forms.png");

  Items item2 = new Items(
    title: "Staff List",
    subtitle: "Adminstration, Faculty, etc...",
    event: "",
    img: "assets/Staff.png",
  );
  Items item3 = new Items(
    title: "Discussion Board",
    subtitle: "Questions here",
    event: "",
    img: "assets/Discussion.png",
  );
  Items item4 = new Items(
    title: "Organization Board",
    subtitle: "UP Orgs",
    event: "",
    img: "assets/Forms.png",
  );
  Items item5 = new Items(
    title: "UPC Map",
    subtitle: "Search Location",
    event: "",
    img: "assets/Map.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "",
    img: "assets/Setting.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  x = getvalue(data.title);
                });
                print(x);
                if (x == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage())); //go to forms page
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

int getvalue(String title) {
  if (title == 'Forms') {
    print('hello');
    return 1;
  } else {
    return 0;
    // function invokes itself
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}

class Home extends StatefulWidget {
  final FirebaseUser user;
  Home(this.user);
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDetails(),
      appBar: AppBar(
        title: Text("Up How To's"),
        centerTitle: true,
        backgroundColor: maroon,
      ),
      backgroundColor: maroon,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashBoard(user)
        ],
      ),
    );
  }
}
