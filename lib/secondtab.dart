import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:Dextro/data.dart';

class SecondTab extends StatefulWidget {
  @override
  SecondTabState createState() => new SecondTabState();
}

class SecondTabState extends State<SecondTab> {

  List<String> albumList;

  void setalbumsongs() async {
    albumList = await filteralbums(songs);
    setState(() {});
  }

  Future<List<String>> filteralbums(List<Song> l) async {
    List<String> ret = new List();
    for (int i = 0; i < l.length; i++) {
      int j;
      for (j = 0; j < i; j++) if (l[i].album == l[j].album) break;
      if (i == j) ret.add(l[i].album);
    }
    return ret;
  }

  void initState() {
    super.initState();
    setalbumsongs();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
          itemCount: (albumList == null) ? 0 : albumList.length,
          itemBuilder: (context, int index) {
            return new ListTile(
              title: new Text(albumList.elementAt(index)),
              onTap: () {
                album = albumList.elementAt(index);
                Navigator.of(context).pushNamed('/AlbumSong');
              },
            );
          });
  }
}
