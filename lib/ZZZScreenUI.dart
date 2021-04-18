import 'package:flutter/material.dart';
import 'mainDrawerDetails.dart';
import 'mainDashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';

final maroon = const Color(0xFF8A1538);

class HomeFormsPage extends StatefulWidget {
  @override
  HomeFormsState createState() => new HomeFormsState();
}

class HomeFormsState extends State<HomeFormsPage> {
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
                    onPressed: () {},
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/FormsPage");
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
                      Navigator.pushNamed(context, "/FormsPage");
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/FormsPage");
                  }),
            ],
          ),
        ));
  }
}

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maroon,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://i.imgur.com/GnUK44v.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 70.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 20, color: maroon),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: maroon),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: "E-mail"),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 24, color: maroon),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: maroon),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: "Username"),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 24, color: maroon),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: maroon),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: "Password"),
              ),
            ),
            SizedBox(height: 20.0),
            CheckboxListTile(
              secondary: const Icon(Icons.file_copy),
              title: const Text('I have accepted the terms and agreements'),
              value: flag,
              onChanged: (value) {
                setState(() {
                  //flag = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/Home");
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(250, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogInPage extends StatefulWidget {
  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
        title: Text('Up How To'),
        centerTitle: true,
        backgroundColor: maroon,
      ),*/
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://i.imgur.com/JEptZSp.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 24, color: maroon),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: maroon),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: "Email"),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 24, color: maroon),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: maroon),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: "Password"),
              ),
            ),
            SizedBox(height: 25.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  print("hello");
                  Navigator.pushReplacementNamed(context, "/Home");
                },
                child: Text('Log-in'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(250, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/SignUpPage");
                },
                child: Text('Create Account'),
                style: ElevatedButton.styleFrom(
                  primary: maroon,
                  onPrimary: Colors.white,
                  minimumSize: Size(150, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
