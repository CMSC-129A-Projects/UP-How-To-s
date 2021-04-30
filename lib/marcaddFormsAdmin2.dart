/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final maroon = const Color(0xFF8A1538); // UP MAROON
//Just edit addforms into updateforms, they're still the same thing I think? Just naa lay gamay manipulation of current data and stuffles, go backend team we'll try to explain
//the code if needed

class AddForms extends StatefulWidget {
  @override
  _AddFormsState createState() => _AddFormsState();
}

class _AddFormsState extends State<AddForms> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> stepsList = [null]; //this is where the list of steps is placed, manipulate this para masulod/makakuha from the database

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add Forms',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Helvetica',
              ),
            ),
            Text(
              'Administrator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
        backgroundColor: maroon,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.white,
            onPressed: () {
              final snackBar = SnackBar(content: Text('This is just filler para ma-center ag Title... dunno what to put here'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, //insert go to addforms here
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          color: Colors.white,
          onPressed: () {
            final snackBar = SnackBar(content: Text('Side-thingy'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          key: _formKey,
          children: <Widget>[
            Row( //Form Name
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: Text(
                    "Form Name:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), 
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: Container(
                      height: 30,
                      child: TextFormField(
                        controller: this.title,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 2),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v){
                          if(v.trim().isEmpty) return 'Please enter step here';
                          return null;
                        }
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row( //Steps Row
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Steps: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ..._getSteps(),
            Row( //Download Forms Text
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Download Form Links Here: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row( //Download Forms Textbox
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Container(
                      child: TextFormField(
                        controller: this.url,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: OutlineInputBorder(),
                          hintText: 'https...',
                        ),
                        validator: (v){
                          if(v.trim().isEmpty) return 'Please enter step here';
                          return null;
                        }
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row( //Submit Button
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(maroon),
                      backgroundColor: MaterialStateProperty.all<Color>(maroon),
                    ),
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        final snackBar = SnackBar(content: Text('Submitted, maybe'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getSteps(){
    List<Widget> stepsTextFields = [];
    for (int i = 0; i<stepsList.length; i++){
      stepsTextFields.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: StepsTextFields(i)
                ),
              ),
              SizedBox(width: 10,),
              _addRemoveButton(i == stepsList.length-1, i),
            ],
          ),
        ),
      );
    }
    return stepsTextFields;
  }

  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if (add){
          stepsList.add(null);
        }
        else stepsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : maroon,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }

}

class StepsTextFields extends StatefulWidget {
  final int index;
  StepsTextFields(this.index);

  @override
  _StepsTextFieldsState createState() => _StepsTextFieldsState();
}

class _StepsTextFieldsState extends State<StepsTextFields> {

TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _AddFormsState.stepsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: (v) => _AddFormsState.stepsList[widget.index] = v,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        border: OutlineInputBorder(),
        hintText: 'Step n',
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter step here';
        return null;
      }
    );
  }
} */
