import 'dart:io';
import 'dart:math';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  Homepage createState() => new Homepage();
}

class Homepage extends State<MyApp> {
  MusicFinder audioPlayer;
  List<Song> demsongs;
  var isPlaying=false;

  @override
  void initState() {
    super.initState();
    _getsongspls();
  }

  Future play(String url) async {
    final result = await audioPlayer.play(url, isLocal: true);
    isPlaying=true;
  }

  pause() async {
    final result = await audioPlayer.pause();
    isPlaying=false;
  }

  void _getsongspls() async {
    audioPlayer = new MusicFinder();
    demsongs = await MusicFinder.allSongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget home() {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Dextro"),
        ), //AppBar
        body: new ListView.builder(
          itemCount: (demsongs == null) ? 0 : demsongs.length,
          itemBuilder: (context, int index) {
            return new ListTile(
                leading: new CircleAvatar(
                  backgroundColor: darkAccentColorpt2,
                ), //CircleAvatar
                title: new Text(demsongs[index].title),
                onTap: () {
                      if(isPlaying==false)
                      {
                        play(demsongs[index].uri);
                      }
                      else
                        if(isPlaying==true)
                        {
                          pause();
                          if(isPlaying==false)
                            play(demsongs[index].uri);
                        }
                      /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MusicLayout()),
                    ); //Navigator
                */
                }//OnTap
            ); //ListTile
          },
        ), //ListView.Builder
      );
    }
    return new MaterialApp(
      home: home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class MusicLayout extends StatefulWidget {
  @override
  _MusicLayoutState createState() => new _MusicLayoutState();
}

class _MusicLayoutState extends State<MusicLayout> {

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
            ), //Icon
            onPressed: () {
              Navigator.pop(context);
            }
        ), //IconButton
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.menu,
                color: icons,
              ), //Icon
              onPressed: null
          ) //IconButton
        ], //<widget>
      ), //appBar
      body: new Column(
        children: <Widget>[
          //Seek bar
          new Expanded(               //Album Art
            child: new Center(
              child: new Container(
                width: 125.0,
                height: 125.0,
                  child: new DecoratedBox(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/butmun.jpg')
                          )//DecorationImage
                      )//BoxDecoration
                  ),//DecoratedBox
              ), //Container
            ), //Center
          ), //Expanded

          //Song details
          new Container(
            color: darkAccentColorpt2,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
              child: new Column(
                children: <Widget>[
                  new RichText(
                    text: new TextSpan(
                        text: '',
                        children: [
                          new TextSpan(
                            text: 'SONG TITLE\n',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4.0,
                              height: 1.5,
                            ), //TextStyle
                          ), //TextSpan
                          new TextSpan(
                              text: 'ARTIST NAME',
                              style: new TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: 12.0,
                                letterSpacing: 3.0,
                                height: 1.5,
                              ) //TextStyle
                          ) //TextSpan
                        ]
                    ), //TextSpan
                  ), //RichText
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
                            ), //Icon
                            onPressed: null
                        ), //IconButton
                        new Expanded(child: new Container()),
                        new RawMaterialButton(
                          shape: new CircleBorder(),
                          fillColor: Colors.white,
                          splashColor: darkAccentColorpt2,
                          highlightColor: darkAccentColorpt2.withOpacity(0.5),
                          elevation: 10.0,
                          highlightElevation: 5.0,
                          onPressed: null,
                          child: new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Icon(
                                Icons.play_arrow,
                                color: darkAccentColorpt2,
                                size: 35.0,
                              ) //Icon
                          ), //Padding
                        ), //RawMaterialButton
                        new Expanded(child: new Container()),
                        new IconButton(
                            icon: new Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 35.0,
                            ), //Icon
                            onPressed: (){
                                //TODO
                            }), //IconButton
                        new Expanded(child: new Container()),
                      ], //<Widget>
                    ),//Row
                  )//Padding
                ],//<Widget>
              ),//Column
            ),//Padding
          )//Container
        ],//<Widget>
      ),//Column
    ); //Scaffold
  }
}
