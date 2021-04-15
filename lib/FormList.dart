import 'package:flutter/material.dart';
final maroon = const Color(0xFF8A1538); 

class Form {
  String formName;
  String formDetails;
  String img;
  Form({this.formName, this.formDetails, this.img});
}



class FormsList extends StatefulWidget {
  @override
  FormsListState createState() => FormsListState();
}

class FormsListState extends State<FormsList> {
  List<Widget> _formTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addForms();
  }

  void _addForms() {
    List<Form> _forms = [
      Form(
          formName: 'Form 5A',
          formDetails: 'Form given after enrollment',
          img: ''),
      Form(
          formName: 'Dropping Form',
          formDetails: 'Form for dropping a subject',
          img: ''),
    ];

    _forms.forEach((Form form) {
      _formTiles.add(_buildTile(form));
    });
  }

  Widget _buildTile(Form form) {
    return ListTile(
      dense:true,
      contentPadding: EdgeInsets.all(5),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(form.formName, style: TextStyle(fontSize: 20, color: maroon)),
          Text('${form.formDetails}',
              style: TextStyle(
                  fontSize: 12,
                  //fontWeight: FontWeight.bold,
                  color: Colors.grey[600])),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.download_sharp,
          color: Colors.grey[400],
          size: 30,
        ),
        onPressed: () {},
      ),
      leading:IconButton(
        icon: Icon(
          Icons.account_balance_sharp,
          color: Colors.grey[400],
          size: 30,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _listKey,
        itemCount: _formTiles.length,
        itemBuilder: (context, index) {
          return _formTiles[index];
        });
  }
}
class FormsPage extends StatefulWidget {
  @override
  FormsPageState createState() => FormsPageState();
}

class FormsPageState extends State<FormsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bGlicmFyeXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                SizedBox(
                  height: 160,
                  child: Text(
                    'Forms',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: FormsList(),
                )
                //Sandbox(),
              ],
            )));
  }
}