import 'package:flutter/material.dart';

class StaffItem extends StatelessWidget {
  final String name;
  final String position;
  final String location;

  StaffItem(
      {Key key, this.name, this.position, this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textPortion = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name ?? 'Staff',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Helvetica-Bold',
            color: Theme.of(context).primaryColor,
          ),
        ),
        // SizedBox(
        //   height: 2.0,
        // ),
        Text(
          this.position != null
              ? '${this.position}'
              : 'Position, located at this location',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Helvetica',
            color: Colors.grey[850],
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        Text(
          this.position != null
              ? 'Office located at ${this.location}'
              : 'Office located at this location',
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
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 10.0,
      ),
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
          Expanded(
            flex: 8,
            child: textPortion,
          ),
          Expanded(
            flex: 1,
            child: PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              onSelected: (item) => onSelected(context, item),
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

  Container buildButton(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: IconButton(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        icon: Icon(
          Icons.more_vert_outlined,
          color: Theme.of(context).primaryColor,
        ),
        splashColor: Colors.white24,
        splashRadius: 20.0,
        onPressed: () => {},
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        //Edit Item
        break;
      case 1:
        //Remove Item
        break;
    }
  }
}
