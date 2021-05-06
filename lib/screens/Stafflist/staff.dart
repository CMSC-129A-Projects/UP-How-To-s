import 'package:flutter/material.dart';

class Staff{
  String _name;
  String get name => _name;
  String _position;
  String get position => _position;
  String _location;
  String get location => _location;
  String _contacts;
  String get contacts => _contacts;

  Staff(this._name, this._position, this._location);

  void changeValues(String n, String p, String l, String c) {
    _name = n;
    _position = p;
    _location = l;
    _contacts = c;
  }
}
