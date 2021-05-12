import 'package:firebase_database/firebase_database.dart';

class Staff {
  String _name;
  String get name => _name;
  String _position;
  String get position => _position;
  String _location;
  String get location => _location;
  String _contacts;
  String get contacts => _contacts;

  Staff(this._name, this._position, this._location, this._contacts);

  void changeValues(String n, String p, String l, String c) {
    _name = n;
    _position = p;
    _location = l;
    _contacts = c;
  }
}
