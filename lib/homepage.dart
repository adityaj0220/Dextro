import 'package:Dextro/data.dart';
import 'package:Dextro/firsttab.dart' as firsttab;
import 'package:Dextro/secondtab.dart' as secondtab;
import 'package:Dextro/thirdtab.dart' as thirdtab;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DextroApp extends StatefulWidget {
  @override
  _DextroState createState() => new _DextroState();
}

class _DextroState extends State<DextroApp>
    with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: null,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Username'),
              decoration: BoxDecoration(
                  color: Colors.indigoAccent
              ),
            ),
            ListTile(
                title: Text('Themes'),
                onTap: (){
                  
                },
            ),
            ListTile(
                title: Text('About'),
                onTap: (){
                  Navigator.of(context).pushNamed('/AboutPage');
                }
            )
          ],
        ),
      ),
        appBar: new AppBar(
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
          title: new Text("Dextro"),
          bottom: new TabBar(
            controller: controller,
            tabs: <Widget>[
              new Tab(icon: new Icon(Icons.music_note)),
              new Tab(icon: new Icon(Icons.album)),
              new Tab(icon: new Icon(Icons.person))
            ],
          ),
        ),
        body: new TabBarView(
            controller: controller,
            children: <Widget>[
            new firsttab.FirstTab(()=>setState((){})),
        new secondtab.SecondTab(),
        new thirdtab.ThirdTab()
        ]
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
                  play(currentPlaylist[indexbackup].uri);
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

