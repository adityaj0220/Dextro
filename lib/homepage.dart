import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

class DextroApp extends StatefulWidget {
  @override
  _DextroState createState() => new _DextroState();
}

class _DextroState extends State<DextroApp> {
  MusicFinder audioPlayer;
  List<Song> demsongs;
  var isPlaying = false;
  var indexbackup;
  var isPaused=false;

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
    isPaused=true;
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
        backgroundColor: Colors.blue,
        title: new Text("Dextro"),
      ), //AppBar
      body: new ListView.builder(
        itemCount: (demsongs == null) ? 0 : demsongs.length,
        itemBuilder: (context, int index) {
          var s = demsongs[index];
          var art = (s.albumArt == null) ? null : new File.fromUri(Uri.parse(s.albumArt));
          return new ListTile(
              leading: new CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: (art!=null) ? new Image.file(art,
                  fit: BoxFit.cover
                ): new Icon(
                    Icons.music_note,
                    color: Colors.white
                  )
              ),
              title: new Text(s.title),
              subtitle: new Text(s.artist),
              onTap: () {
                if (!isPlaying) {
                  if(isPaused)
                    {
                      stop();
                      play(s.uri);
                      indexbackup = index;
                      setState(() {});
                    }
                  play(s.uri);
                  indexbackup = index;
                  setState(() {});
                }
                else
                  {
                    stop();
                    play(s.uri);
                    indexbackup = index;
                    setState(() {});
                  }
              } //OnTap
          ); //ListTile
        }, //ItemBuilder
      ), //ListView.Builder
      bottomNavigationBar: new BottomAppBar(
          color: Colors.black,
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
              new IconButton(icon: (isPlaying)?Icon(Icons.pause):Icon(Icons.play_arrow),
                color: Colors.white,
                onPressed: () {
                  if (isPlaying) {
                    pause();
                    setState(() {});
                  }
                  else if(!isPlaying)
                    { play(demsongs[indexbackup].uri);
                      setState(() {});
                    }
                },
              ) //IconButton
            ], //<Widget>
          ) //Row
      ), //BottomAppBar
    ); //Scaffold
  }

}

