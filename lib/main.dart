import 'package:Dextro/albumcontent.dart';
import 'package:Dextro/artistcontent.dart';
import 'package:Dextro/homepage.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'songinfo.dart';
import 'package:flutter/material.dart';


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
        theme: ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          '/MusicLayout': (BuildContext context) => new MusicLayout(),
          '/AlbumSong': (BuildContext context) => new AlbumSong(),
          '/ArtistSong': (BuildContext context) => new ArtistSong(),
        }
    );
  }
}

