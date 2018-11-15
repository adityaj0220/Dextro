import 'dart:io';
import 'dart:math';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:Dextro/data.dart';

class AlbumSong extends StatefulWidget {
  @override
  AlbumSongState createState() => new AlbumSongState();
}

class AlbumSongState extends State<AlbumSong> {
  @override
  void initState() {
    super.initState();
    setsongs();
  }

  void setsongs() async {
    audioPlayer = new MusicFinder();
    songs = await MusicFinder.allSongs();
    songs = await showsongsofalbum(songs);
    setState(() {});
  }

  Future<List<Song>> showsongsofalbum(List<Song> l) async {
    List<Song> ret = new List();
    for (int i = 0; i < l.length; i++) {
      if (l[i].album == album) ret.add(l[i]);
    }
    return ret;
  }

  void playSong(Song song, int index) {
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
      appBar: new AppBar(
        title: new Text('Dextro'),
        backgroundColor: Colors.indigoAccent,
      ),
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
              title: new Text(songs[index].title),
              subtitle: new Text(songs[index].artist),
              onTap: () {
                playSong(songs[index], index);
                currentPlaylist=songs;
              },
            );
          }),
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
