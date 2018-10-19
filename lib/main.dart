import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
   @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{
  MusicFinder audioPlayer;
  List<Song> demsongs;

  @override
  void initState(){
    super.initState();
    getsongspls();
  }

  Future playmoojix(String url) async{
    final result = await audioPlayer.play(url,isLocal: true);
  }

  void getsongspls() async{
    audioPlayer = new MusicFinder();
    demsongs =await MusicFinder.allSongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget home(){
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("moOjix"),
        ), //AppBar
        body: new ListView.builder(
          itemCount: (demsongs == null)?0:demsongs.length,
          itemBuilder: (context,int index){
            return new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.blue,
              ), //CircleAvatar
              title: new Text(demsongs[index].title),
              onTap: ()=>playmoojix(demsongs[index].uri),
            ); //ListTile 
          },
        ), //ListView.Builder
      );
    }
    return new MaterialApp(
        home: home(),
    );
  }
}
