import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:Dextro/data.dart';

class ThirdTab extends StatefulWidget {
  @override
  ThirdTabState createState() => new ThirdTabState();
}

class ThirdTabState extends State<ThirdTab> {
  List<String> artistList;

  void setartistsongs() async {
    artistList = await filterartists(songs);
    setState(() {});
  }

  Future<List<String>> filterartists(List<Song> l) async {
    List<String> ret = new List();
    for (int i = 0; i < l.length; i++) {
      int j;
      for (j = 0; j < i; j++) if (l[i].artist == l[j].artist) break;
      if (i == j) {
        ret.add(l[i].artist);
      }
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
            onTap: (){
              artist = artistList.elementAt(index);
              Navigator.of(context).pushNamed('/ArtistSong');
            },
          );
        },
      ),
      );
  }
}
