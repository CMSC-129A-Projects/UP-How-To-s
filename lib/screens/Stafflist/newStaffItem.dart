import 'package:flutter/material.dart';
import 'package:uphowtos1/screens/Stafflist/staffItem.dart';

class NewStaffItem extends StatefulWidget {
  @override
  _NewStaffItemState createState() => _NewStaffItemState();
}

class _NewStaffItemState extends State<NewStaffItem> {
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  // String _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Staff'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: positionController,
              decoration: InputDecoration(
                hintText: 'Position',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                hintText: 'Office At',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
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
                Navigator.pop(
                  context,
                  StaffItem(
                    name: nameController.text,
                    position: positionController.text,
                    location: locationController.text,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
