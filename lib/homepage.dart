import 'package:Dextro/firsttab.dart' as firsttab;
import 'package:Dextro/secondtab.dart' as secondtab;
import 'package:Dextro/thirdtab.dart' as thirdtab;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Dextro/data.dart';

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
                onTap: null
            ),
            ListTile(
                title: Text('About'),
                onTap: null
            )
          ],
        ),
      ),
        appBar: new AppBar(
          leading: IconButton(
            icon: new Icon(Icons.menu, color: Colors.white),
            onPressed: null,
          ),
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
            new firsttab.FirstTab(),
        new secondtab.SecondTab(),
        new thirdtab.ThirdTab()
        ]
        ),
    );
  }
}
