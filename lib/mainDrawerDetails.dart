import 'package:flutter/material.dart';

final maroon = const Color(0xFF8A1538);

class DrawerDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: maroon,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("https://i.imgur.com/dR11Api.jpeg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'UserILoveYou3000',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'TonyStarkIronMan@up.edu.ph',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_rounded,
            ),
            title: Text(
              "User Profile",
              style: TextStyle(fontWeight: FontWeight.bold, color: maroon),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.file_copy,
            ),
            title: Text(
              "Forms & Processes",
              style: TextStyle(fontWeight: FontWeight.bold, color: maroon),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person_search,
            ),
            title: Text(
              "Personnel Directory",
              style: TextStyle(fontWeight: FontWeight.bold, color: maroon),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.forum,
            ),
            title: Text(
              "Discussion Board",
              style: TextStyle(fontWeight: FontWeight.bold, color: maroon),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.group,
            ),
            title: Text(
              "Organization Board",
              style: TextStyle(fontWeight: FontWeight.bold, color: maroon),
            ),
          ),
        ],
      ),
    );
  }
}
