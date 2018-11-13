import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'dart:io';
import 'dart:math';

Song currentSong;

class FirstTab extends StatefulWidget{
  @override
  FirstTabState createState() => new FirstTabState();
}

class FirstTabState extends State<FirstTab>{

  MusicFinder audioPlayer;
  List<Song> demsongs;
  var isPlaying = false;
  var indexbackup;
  var isPaused = false;
  var isStopped = true;

  @override
  void initState() {
    super.initState();
    setsongs();
  }

  Future play(String url) async {
    audioPlayer.play(url, isLocal: true);
    isPlaying = true;
    isStopped = false;
  }

  pause() async {
    audioPlayer.pause();
    isPlaying = false;
    isPaused = true;
    isStopped = false;
  }

  stop() async {
    audioPlayer.stop();
  }

  void setsongs() async {
    audioPlayer = new MusicFinder();
    demsongs = await MusicFinder.allSongs();
    setState(() {});
  }

  void _playSong(Song song, int index) {
    currentSong = song;
    if (!isPlaying) {
      if (isPaused) {
        stop();
        play(song.uri);
        indexbackup = index;
        setState(() {});
      }
      play(song.uri);
      indexbackup = index;
      setState(() {});
    } else {
      stop();
      play(song.uri);
      indexbackup = index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: (demsongs == null) ? 0 : demsongs.length,
        itemBuilder: (context, int index) {
          var song = demsongs[index];
          var art = (song.albumArt == null)
              ? null
              : new File.fromUri(Uri.parse(song.albumArt));
          return new ListTile(
              leading: (art == null)
                  ? new CircleAvatar(
                child: new Icon(Icons.music_note, color: Colors.white),
                backgroundColor: HSLColor.fromAHSL(
                    1.0, Random().nextDouble() * 360, 0.75, 0.3)
                    .toColor(),
              )
                  : new CircleAvatar(backgroundImage: new FileImage(art)),
              title: new Text(song.title),
              subtitle: new Text(song.artist),
              onTap: () => _playSong(song, index) //OnTap
          );
        },
      ),
      bottomNavigationBar: isStopped
          ? null
          : new BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
                icon: new Icon(Icons.keyboard_arrow_up),
                color: Colors.white,
                onPressed: () {
                  try {
                    Navigator.of(context).pushNamed('/MusicLayout');
                  } catch (e) {
                    print(e.toString());
                  }
                } //OnPressed
            ),
            (!isPlaying)
                ? (isPaused
                ? new Text(demsongs[indexbackup].title,
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 16.0))
                : new Text(''))
                : new Text(
              demsongs[indexbackup].title,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16.0),
            ),
            new IconButton(
              icon: (isPlaying)
                  ? Icon(Icons.pause)
                  : Icon(Icons.play_arrow),
              color: Colors.white,
              onPressed: () {
                if (isPlaying) {
                  pause();
                  setState(() {});
                } else if (!isPlaying) {
                  play(demsongs[indexbackup].uri);
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
