import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'dart:io';
import 'dart:math';

class SecondTab extends StatefulWidget{
  @override
  SecondTabState createState() => new SecondTabState();
}

class SecondTabState extends State<SecondTab>{
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text('Albums',
        style: new TextStyle(fontSize: 30.0),
      ),
    );
  }

}