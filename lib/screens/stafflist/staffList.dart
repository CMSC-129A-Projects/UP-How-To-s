import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:uphowtos1/screens/stafflist/staff.dart';

class StaffList extends ChangeNotifier {
  List<Staff> staff = [];

  int getLength() {
    return staff.length;
  }

  void add(Staff s) {
    staff.add(s);
    notifyListeners();
  }

  void edit(
      {int index,
      String name,
      String position,
      String location,
      String contacts}) {
    staff[index].changeValues(name, position, location, contacts);
    notifyListeners();
  }

  void remove(int index) {
    staff.removeAt(index);
    notifyListeners();
  }
}
