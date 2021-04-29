import 'package:flutter/material.dart';

class StaffItem extends StatelessWidget {
  final String name;
  final String position;
  final String location;
  final String description;

  StaffItem(
      {Key key, this.name, this.position, this.location, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textPortion = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name ?? '(Unnamed Staff)',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Helvetica-Bold',
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        Text(
          '${this.position}, at ${this.location}' ?? 'Position, located at this location',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Helvetica',
            color: Colors.grey[850],
          ),
        ),
      ],
    );


    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(
        bottom: 5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          textPortion,
        ],
      ),
    );
  }
}
