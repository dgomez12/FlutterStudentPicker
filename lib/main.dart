import 'dart:math';

import 'package:finalproject/send_receive.dart';
import 'package:finalproject/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/settings.dart';
import 'about.dart';
import 'add_name.dart';

//Author: Denzel Gomez, Course: ITEC 4550, Date: 5/1/2020

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Student> _studentList = <Student>[];
  List<String> _imgList = <String>[
    "assets/rose.png",
    "assets/thorn.png",
    "assets/bud.png",
  ];
  String _displayedName = "";
  String _displayedImg = "";
  final _random = new Random();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: Text("List is empty or all items are hidden")
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('GGC Thorns, Roses and Buds'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Settings.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            }
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            child: Image(
              height: 96,
              image: AssetImage('assets/bbuildingwavy.jpg'),
            ),
            onTap: (){
              setState(() {
                _fillList();
              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(_displayedName, textAlign: TextAlign.center),
              ),
              FittedBox(
                  fit: BoxFit.fill,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 3, width: 1,),
                      Image.asset(_displayedImg)
                    ],
                  ),
                ),
            ],
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: _studentList.length,
              itemBuilder: (BuildContext context, int position) {
                final student = _studentList[position];
                return Dismissible(
                  key: Key(student.name),
                  onDismissed: (direction){
                    setState(() {
                      _studentList.removeAt(position);
                    });
                  },
                  background: Container(color: Colors.red),
                  child: getRow(position),
                );
              }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_studentList.isEmpty || _checkIfAllHidden() == true){
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }else
          setState(() {
            _displayedImg = _pickImg();
            _displayedName = _pickName();
            print(_displayedImg);
            print(_displayedName);
          });
        },
        child: Icon(Icons.sync),
      ),
    );
  }

  void choiceAction(String choice){
    if(choice == Settings.sendReceive){
      print('Send/Receive option');
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new SendReceive()));
    }else if(choice == Settings.addName){
      print('Add Name option');
      _openDialogAddItem();
    }else if(choice == Settings.sort){
      print('Sort option');
      setState(() {
        _studentList.sort((a,b) => a.name.compareTo(b.name));
      });
    }else if(choice == Settings.shuffle){
      print('Shuffle option');
      setState(() {
        _studentList.shuffle();
      });
    }else if(choice == Settings.clear){
      print('Clear option');
      setState(() {
        _studentList.clear();
        _displayedImg = "";
        _displayedName = "";
      });
    }else if(choice == Settings.about){
      print('About option');
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new AboutPage()));
    }
  }

  Widget getRow(int position) {
    return new FlatButton(
      child: new ListTile(
        title: new Text(_studentList[position].name),
        trailing: (_studentList[position].hidden == true) ? Icon(Icons.visibility_off):null,
      ),
      onPressed: () {
        setState(() {
          if(_studentList[position].hidden == false){
            _studentList[position].hidden = true;
          }else{
            _studentList[position].hidden = false;
          }
        });
      },
    );
  }

  bool _checkIfAllHidden(){
    for(int i = 0; i < _studentList.length; i++){
      if(_studentList[i].hidden==false){
        return false;
      }
    }
    return true;
  }

  void _fillList(){
    Student s1 = new Student("Denzel", false);
    Student s2 = new Student("Byron", false);
    Student s3 = new Student("Nely", false);
    Student s4 = new Student("Patty", false);
    Student s5 = new Student("Karla", false);
    _studentList.add(s1);
    _studentList.add(s2);
    _studentList.add(s3);
    _studentList.add(s4);
    _studentList.add(s5);
  }

  String _pickImg(){
    if(_studentList.isEmpty){
      return "";
    }else
      return _imgList[_random.nextInt(_imgList.length)];
  }

  String _pickName(){
    if(_studentList.isEmpty){
      return "";
    }else
      return _pickNameHelper(_studentList[_random.nextInt(_studentList.length)]);
  }

  String _pickNameHelper(Student s){
    if(s.hidden == true){
      return _pickName();
    }else{
      return s.name;
    }
  }

  Future _openDialogAddItem() async {
    Student student = await Navigator.of(context).push(
      new MaterialPageRoute<Student>(
        builder: (BuildContext context) {
          return new AddName();
        },
        fullscreenDialog: true
      )
    );
    setState(() {
      _studentList.add(student);
    });
  }

}
