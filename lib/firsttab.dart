import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'dart:io';
import 'dart:math';
import 'package:Dextro/data.dart';

class FirstTab extends StatefulWidget {
  @override
  FirstTabState createState() => new FirstTabState();
}

class FirstTabState extends State<FirstTab> {
  @override
  void initState() {
    super.initState();
    setsongs();
  }

  void playSong(Song song, int index) {
    currentSong = song;
    currentPlaylist = songs;
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

  void setsongs() async {
    audioPlayer = new MusicFinder();
    songs = await MusicFinder.allSongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: (songs == null) ? 0 : songs.length,
        itemBuilder: (context, int index) {
          var song = songs[index];
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
              subtitle: (song.artist == '<unknown>')
                  ? new Text('Unknown')
                  : new Text(song.artist),
              onTap: () {
                playSong(song, index);
                currentPlaylist = songs;
              } //OnTap
              );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          int n = new Random().nextInt(songs.length - 1);
          if (isStopped) {
            currentSong = songs[n];
            playSong(currentSong, n);
          } else if (isPaused || isPlaying) {
            stop();
            currentSong = songs[n];
            playSong(currentSong, n);
          }
          setState(() {});
        },
        child: new Icon(
          Icons.shuffle,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: isStopped
          ? null
          : new BottomAppBar(
              color: Colors.indigoAccent,
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
                          ? new Text(currentPlaylist[indexbackup].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16.0))
                          : new Text(''))
                      : new Text(
                          currentPlaylist[indexbackup].title,
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
                        playSong(currentSong, indexbackup);
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
