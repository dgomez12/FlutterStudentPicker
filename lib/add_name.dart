import 'package:finalproject/main.dart';
import 'package:finalproject/student.dart';
import 'package:flutter/material.dart';

class AddName extends StatefulWidget {
  @override
  _AddNameState createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  bool _canSave = false;
  Student _student = new Student.empty();

  void _setCanSave(bool save){
    if(save != _canSave)
      setState(() {
        _canSave = save;
      });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Add Student Name'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("ADD", style: theme.textTheme.body1.copyWith(color: _canSave ? Colors.white :
            new Color.fromRGBO(255, 255, 255, 0.5)),
            ),
            onPressed: _canSave ? (){
              Navigator.of(context).pop(_student);} : null
          )
        ],
      ),
      body: new Form(
        child: new ListView(
          padding: const EdgeInsets.symmetric(vertical: 4.0,
          horizontal: 16.0),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: "Add Name"
              ),
              onChanged: (String value){
                _student.name = value;
                _setCanSave(value.isNotEmpty);
              },
            ),
          ].toList(),
        ),
      ),
    );
  }
}
