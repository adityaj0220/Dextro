import 'package:flutter/material.dart';

class ThirdTab extends StatefulWidget{
  @override
  ThirdTabState createState() => new ThirdTabState();
}

class ThirdTabState extends State<ThirdTab>{
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text('Artists',
        style: new TextStyle(fontSize: 30.0),
      ),
    );
  }
}