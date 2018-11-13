import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:Dextro/functions.dart';

class ThirdTab extends StatefulWidget {
  @override
  ThirdTabState createState() => new ThirdTabState();
}

class ThirdTabState extends State<ThirdTab> {
  List<Song> artistsongs;
  MusicFinder audioPlayer;
  List<String> artistList;

  void setartistsongs() async {
    audioPlayer = new MusicFinder();
    artistsongs = await MusicFinder.allSongs();
    artistList = filterartists(artistsongs);
    setState(() {});
  }

  List<String> filterartists(List<Song> l) {
    List<String> ret = new List();
    for (int i = 0; i < l.length; i++) {
      int j;
      for (j = 0; j < i; j++)
        if (l[i].artist == l[j].artist)
          break;
      if (i == j)
        ret.add(l[i].artist);
    }
    return ret;
  }

  void initState() {
    super.initState();
    setartistsongs();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: (artistList == null) ? 0 : artistList.length,
        itemBuilder: (context, int index) {
          return new ListTile(
            title: new Text(artistList.elementAt(index)),
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
                ? new Text(songs[indexbackup].title,
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 16.0))
                : new Text(''))
                : new Text(
              songs[indexbackup].title,
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
                  play(songs[indexbackup].uri);
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
