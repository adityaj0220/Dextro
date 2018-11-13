import 'package:flutter/material.dart';
import 'package:Dextro/functions.dart';

class SecondTab extends StatefulWidget{
  @override
  SecondTabState createState() => new SecondTabState();
}

class SecondTabState extends State<SecondTab>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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