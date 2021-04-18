import 'package:flutter/material.dart';
import 'mainDrawerDetails.dart';
import 'formsAcadNon.dart';

final maroon = const Color(0xFF8A1538);

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: DrawerDetails(),
        appBar: AppBar(
          title: Text("Up How To's"),
          centerTitle: true,
          backgroundColor: maroon,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  child: Image.network(
                'https://i.imgur.com/XeETXG9.png',
                height: 360,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )),
              SizedBox(height: 30),
              ListTile(
                  title: Text('Academic Forms',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[800])),
                  subtitle: Text(
                      'These forms include enrollment,dropping and other academic forms',
                      style: TextStyle(letterSpacing: 1)),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: Colors.grey[400],
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcadsFormsPage()));
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AcadsFormsPage()));
                  }),
              ListTile(
                  title: Text('Non-Academic Forms',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[800])),
                  subtitle: Text(
                      'These forms are for requesting places and orgstuff',
                      style: TextStyle(letterSpacing: 1)),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.file_copy_rounded,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NonFormsPage()));
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NonFormsPage()));
                  }),
            ],
          ),
        ));
  }
}
