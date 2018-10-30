import 'dart:io';
import 'dart:math';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DextroAppWrapper();
  }
}

class DextroAppWrapper extends StatefulWidget {
  @override
  _DextroAppWrapperState createState() => new _DextroAppWrapperState();
}

class _DextroAppWrapperState extends State<DextroAppWrapper> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new DextroApp(),
        debugShowCheckedModeBanner: true,
        theme: new ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          '/MusicLayout': (BuildContext context) => new MusicLayout(),
        }
    );
  }
}


class DextroApp extends StatefulWidget {
  @override
  _DextroState createState() => new _DextroState();
}

class _DextroState extends State<DextroApp> {
  MusicFinder audioPlayer;
  List<Song> demsongs;
  var isPlaying = false;

  @override
  void initState() {
    super.initState();
    getsongspls();
  }

  Future play(String url) async {
    audioPlayer.play(url, isLocal: true);
    isPlaying = true;
  }

  pause() async {
    audioPlayer.pause();
    isPlaying = false;
  }

  stop() async {
    audioPlayer.stop();
  }

  void getsongspls() async {
    audioPlayer = new MusicFinder();
    demsongs = await MusicFinder.allSongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.indigoAccent,
        title: new Text("Dextro"),
      ), //AppBar
      body: new ListView.builder(
        itemCount: (demsongs == null) ? 0 : demsongs.length,
        itemBuilder: (context, int index) {
          return new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.teal,
                child: new Text(demsongs[index].title[0].toUpperCase(),
                  style: TextStyle(color: Colors.black87,
                      fontWeight: FontWeight.bold
                  ), //TextStyle
                ), //Text
              ), //CircleAvatar
              title: new Text(demsongs[index].title),
              onTap: () {
                if (isPlaying == false) {
                  play(demsongs[index].uri);
                }
                else if (isPlaying == true) {
                  stop();
                  play(demsongs[index].uri);
                }
              } //OnTap
          ); //ListTile
        }, //ItemBuilder
      ), //ListView.Builder
      bottomNavigationBar: new BottomAppBar(
          color: Colors.indigoAccent,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.keyboard_arrow_up),
                  color: Colors.white,
                  onPressed: () {
                    try {
                      Navigator.of(context).pushNamed('/MusicLayout');
                    } catch (e) {
                      print(e.toString());
                    }
                  } //OnPressed
              ), //IconButton
              new IconButton(icon: new Icon(Icons.pause),
                color: Colors.white,
                onPressed: () {
                  if (isPlaying == true) {
                    pause();
                  }
                },
              ) //IconButton
            ], //<Widget>
          ) //Row
      ), //BottomAppBar
    ); //Scaffold,
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
          new Expanded( //Album Art
            child: new Center(
              child: new Container(
                width: 125.0,
                height: 125.0,
                child: new DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/butmun.jpg')
                        ) //DecorationImage
                    ) //BoxDecoration
                ), //DecoratedBox
              ), //Container
            ), //Center
          ), //Expanded

          //Song details
          new Container(
            color: Colors.indigoAccent,
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
                          splashColor: Colors.indigoAccent,
                          highlightColor: Colors.indigoAccent.withOpacity(0.5),
                          elevation: 10.0,
                          highlightElevation: 5.0,
                          onPressed: null,
                          child: new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Icon(
                                Icons.play_arrow,
                                color: Colors.indigoAccent,
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
                            onPressed: () {
                              //TODO
                            }), //IconButton
                        new Expanded(child: new Container()),
                      ], //<Widget>
                    ), //Row
                  ) //Padding
                ], //<Widget>
              ), //Column
            ), //Padding
          ) //Container
        ], //<Widget>
      ), //Column
    ); //Scaffold
  }
}

