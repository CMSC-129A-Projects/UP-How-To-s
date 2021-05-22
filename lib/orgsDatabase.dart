import 'package:firebase_database/firebase_database.dart';
import 'orgs.dart';

final databaseReference = FirebaseDatabase.instance.reference();
DatabaseReference saveOrgs(Orgs orgs) {
  var id = databaseReference.child('orgs/').push();
  id.set(orgs.toJson());
  return id;
}

void updateOrgs(Orgs orgs, DatabaseReference id) {
  id.update(orgs.toJson());
}

Future<List<Orgs>> getAllOrgs() async {
  DataSnapshot dataSnapshot = await databaseReference.child('orgs/').once();
  List<Orgs> orgs = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Orgs org = createOrgs(value);
      org.setId(databaseReference.child('orgs/' + key));
      //print(key);
      orgs.add(org);
    });
  }
  return orgs;
}
