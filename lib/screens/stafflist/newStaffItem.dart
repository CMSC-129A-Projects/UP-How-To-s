import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/screens/stafflist/staff.dart';
import 'package:uphowtos1/screens/Stafflist/staffList.dart';

// ignore: must_be_immutable
class NewStaffItem extends StatelessWidget {
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final locationController = TextEditingController();
  final contactsController = TextEditingController();

  String name;
  String position;
  String location;
  String contacts;
  int index;

  // NewStaffItem has two constructors:
  // NewStaffItem() empty constructor for adding new staff item
  // NewStaffItem.fromStaff() editing existing staff members
  NewStaffItem();
  NewStaffItem.fromStaff({
    this.name,
    this.position,
    this.location,
    this.contacts,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    // context.watch<StaffList>() is used to connect the instatiated staffList
    // which can be found in main.dart
    final staff = context.watch<StaffList>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.name != null ? 'Edit Staff' : 'Add Staff',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _nameInputBox(context),
                SizedBox(height: 10.0),
                _positionInputBox(context),
                SizedBox(height: 10.0),
                _locationInputBox(context),
                SizedBox(height: 10.0),
                _contactsInputBox(),
                SizedBox(height: 10.0),
                _submitButton(staff, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _submitButton(StaffList staff, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          // backgroundColor: Theme.of(context).primaryColor,
          ),
      child: Text(
        'Submit',
        style: TextStyle(
          fontFamily: 'Helvetica',
          fontSize: 15.0,
        ),
      ),
      onPressed: () {
        // calls stafflist.add and add new staff
        if (this.name != null) {
          staff.edit(
            index: index,
            name: nameController.text,
            position: positionController.text,
            location: locationController.text,
            contacts: contactsController.text,
          );
        } else {
          staff.add(
            Staff(
              nameController.text,
              positionController.text,
              locationController.text,
              contactsController.text,
            ),
          );
        }
        // pops the current screen from the materialroutestack which leads back
        // to staffLisPage
        Navigator.pop(context);
      },
    );
  }

  InputDecoration inDecor(String txt) => InputDecoration(
        labelText: txt,
        border: OutlineInputBorder(),
      );

  Widget _nameInputBox(BuildContext context) => TextFormField(
        // nameController..text = name is used in order to prefill if it is on
        // edit staff mode
        controller: nameController..text = name,
        decoration: inDecor('Name'),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );

  Widget _positionInputBox(BuildContext context) => TextFormField(
        controller: positionController..text = position,
        decoration: inDecor('Position'),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );

  Widget _locationInputBox(BuildContext context) => TextFormField(
        controller: locationController..text = location,
        decoration: inDecor('Location'),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );

  Widget _contactsInputBox() => TextFormField(
        controller: contactsController..text = contacts,
        decoration: inDecor('Contacts'),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );
}
