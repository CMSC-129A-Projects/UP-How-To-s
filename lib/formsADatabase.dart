import 'package:firebase_database/firebase_database.dart';
import 'formsA.dart';

final databaseReference = FirebaseDatabase.instance.reference();
DatabaseReference saveFormsA(FormsA formsA) {
  var id = databaseReference.child('formsA/').push();
  id.set(formsA.toJson());
  return id;
}

void updateFormsA(FormsA formsA, DatabaseReference id) {
  id.update(formsA.toJson());
}

Future<List<FormsA>> getAllFormsA() async {
  DataSnapshot dataSnapshot = await databaseReference.child('formsA/').once();
  List<FormsA> formsA = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      FormsA formA = createFormsA(value);
      formA.setId(databaseReference.child('formsA/' + key));
      formsA.add(formA);
    });
  }
  return formsA;
}
