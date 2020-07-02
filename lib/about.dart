import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('GGC Thorns, Roses and Buds'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 96,
            color: Colors.white,
            child: Image(
              image: AssetImage('assets/bbuildingwavy.jpg'),
            ),
          ),
          Container(
            child: Center(
              heightFactor: 4,
              child: Text('Created by Denzel Gomez',
              style: TextStyle(fontSize: 20)),
            ),
          ),
          Container(
            child: Center(
              heightFactor: 0,
              child: Text('Created for ITEC 4550',
              style: TextStyle(fontSize: 16)),
            ),
          ),
          Container(
            child: Center(
              heightFactor: 1.2,
              child: Image(
                image: AssetImage('assets/bearcheering.png'),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text('4/29/2020',
              style: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
