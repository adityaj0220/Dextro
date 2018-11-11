import 'dart:io';
import 'package:Dextro/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:Dextro/homepage.dart';
import 'dart:math';

class MusicLayout extends StatefulWidget {
  @override
  _MusicLayoutState createState() => new _MusicLayoutState();
}

class _MusicLayoutState extends State<MusicLayout> {
  Song song = currentSong;
  var isPlaying = false;
  var indexbackup;
  var isPaused = false;
  //Color currentColor = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
  //    .withOpacity(1.0);
  Color currentColor = HSLColor.fromAHSL(1.0, Random().nextDouble()*360, 0.75, 0.3).toColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: icons,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: new Column(
        children: <Widget>[
          //Seek bar
          new Expanded(
            //Album Art
            child: new Center(
              child: new Container(
                width: 125.0,
                height: 125.0,
                child: new DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/butmun.jpg')))),
              ),
            ),
          ),

          //Song details
          new Container(
            color: currentColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
              child: new Column(
                children: <Widget>[
                  new Text(song.title.toUpperCase(),
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        height: 1.5,
                      )),
                  new Text(song.artist.toUpperCase(),
                      style: new TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 12.0,
                        letterSpacing: 2.0,
                        height: 1.5,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(child: new Container()),
                        new IconButton(
                            icon: new Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            onPressed: () {
                              //TODO
                            }),
                        new Expanded(child: new Container()),
                        new RawMaterialButton(
                          shape: new CircleBorder(),
                          fillColor: Colors.white,
                          splashColor: currentColor.withOpacity(0.75),
                          highlightColor: currentColor.withOpacity(0.2),
                          elevation: 10.0,
                          highlightElevation: 5.0,
                          onPressed: (){

                          },
                          child: new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Icon(
                                Icons.play_arrow,
                                color: currentColor,
                              )),
                        ),
                        new Expanded(child: new Container()),
                        new IconButton(
                            icon: new Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            onPressed: () {
                              //TODO
                            }),
                        new Expanded(child: new Container()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
