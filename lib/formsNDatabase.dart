import 'package:firebase_database/firebase_database.dart';
import 'formsN.dart';

final databaseReference = FirebaseDatabase.instance.reference();
DatabaseReference saveFormsN(FormsN formsN) {
  var id = databaseReference.child('formsN/').push();
  id.set(formsN.toJson());
  return id;
}

void updateFormsN(FormsN formsN, DatabaseReference id) {
  id.update(formsN.toJson());
}

Future<List<FormsN>> getAllFormsN() async {
  DataSnapshot dataSnapshot = await databaseReference.child('formsN/').once();
  List<FormsN> formsN = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      FormsN formN = createFormsN(value);
      formN.setId(databaseReference.child('formsN/' + key));
      print(key);
      formsN.add(formN);
    });
  }
  return formsN;
}
