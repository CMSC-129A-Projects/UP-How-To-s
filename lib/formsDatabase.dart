import 'package:firebase_database/firebase_database.dart';
import 'forms.dart';

final databaseReference = FirebaseDatabase.instance.reference();
DatabaseReference saveForms(Forms forms) {
  var id = databaseReference.child('forms/').push();
  id.set(forms.toJson());
  return id;
}

void updateForms(Forms forms, DatabaseReference id) {
  id.update(forms.toJson());
}

Future<List<Forms>> getAllForms() async {
  DataSnapshot dataSnapshot = await databaseReference.child('forms/').once();
  List<Forms> forms = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Forms form = createForms(value);
      form.setId(databaseReference.child('forms/' + key));
      //print(key);
      forms.add(form);
    });
  }
  return forms;
}
