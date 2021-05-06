import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uphowtos1/screens/Stafflist/staffList.dart';
import 'package:uphowtos1/screens/Stafflist/newStaffItem.dart';

class StaffItem extends StatelessWidget {
  final int index;
  StaffItem({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.watch<StaffList>() is used to connect the instatiated staffList  
    // which can be found in main.dart
    final staff = context.watch<StaffList>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 6, offset: Offset(0, 4)),
        ]
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 8, child: _staffDetailPortion(staff, context)),
          Expanded(
            flex: 1,
            child: PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              onSelected: (item) => onSelected(context, item, staff),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('Edit'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('Remove'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _staffDetailPortion(StaffList staff, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          staff.staff[index].name ?? 'Staff',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Helvetica-Bold',
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          staff.staff[index].position ?? 'Position',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Helvetica',
            color: Colors.grey[850],
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          staff.staff[index].location ?? 'Location',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Helvetica',
            color: Colors.grey[850],
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          staff.staff[index].contacts ?? 'Contact Details',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Helvetica',
            color: Colors.grey[850],
          ),
        ),
      ],
    );
  }

  void onSelected(BuildContext context, int item, StaffList staff) {
    switch (item) {
      case 0:
        //Edit Item
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewStaffItem.fromStaff(
                    staff.staff[index].name,
                    staff.staff[index].position,
                    staff.staff[index].location,
                    staff.staff[index].contacts)));
        break;
      case 1:
        //Remove Item
        // animationKey.currentState
        //     .removeItem(index, (context, aimation) => );
        staff.remove(index);
        break;
    }
  }
}
