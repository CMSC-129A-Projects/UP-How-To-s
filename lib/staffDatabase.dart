import 'package:firebase_database/firebase_database.dart';
import 'staff.dart';

final databaseReference = FirebaseDatabase.instance.reference();
DatabaseReference saveStaff(Staff staff) {
  var id = databaseReference.child('staff/').push();
  id.set(staff.toJson());
  return id;
}

void updateStaff(Staff staff, DatabaseReference id) {
  id.update(staff.toJson());
}

Future<List<Staff>> getAllStaff() async {
  DataSnapshot dataSnapshot = await databaseReference.child('staff/').once();
  List<Staff> staffs = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Staff staff = createStaff(value);
      staff.setId(databaseReference.child('staff/' + key));
      print(key);
      staffs.add(staff);
    });
  }
  return staffs;
}
