import 'package:Dextro/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicLayout extends StatefulWidget {
  @override
  _MusicLayoutState createState() => new _MusicLayoutState();
}

class _MusicLayoutState extends State<MusicLayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: icons,
            ), //Icon
            onPressed: () {
              Navigator.pop(context);
            }
        ), //IconButton
      ), //appBar
      body: new Column(
        children: <Widget>[
          //Seek bar
          new Expanded( //Album Art
            child: new Center(
              child: new Container(
                width: 125.0,
                height: 125.0,
                child: new DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/butmun.jpg')
                        ) //DecorationImage
                    ) //BoxDecoration
                ), //DecoratedBox
              ), //Container
            ), //Center
          ), //Expanded

          //Song details
          new Container(
            color: Colors.indigoAccent,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
              child: new Column(
                children: <Widget>[
                  new RichText(
                    text: new TextSpan(
                        children: [
                          new TextSpan(
                            text: 'SONG TITLE\n',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              height: 1.5,
                            ), //TextStyle
                          ), //TextSpan
                          new TextSpan(
                              text: 'ARTIST NAME',
                              style: new TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: 12.0,
                                letterSpacing: 2.0,
                                height: 1.5,
                              ) //TextStyle
                          ) //TextSpan
                        ]
                    ), //TextSpan
                  ), //RichText
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(child: new Container()),
                        new IconButton(
                            icon: new Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 35.0,
                            ), //Icon
                            onPressed: (){
                              //TODO
                            }
                        ), //IconButton
                        new Expanded(child: new Container()),
                        new RawMaterialButton(
                          shape: new CircleBorder(),
                          fillColor: Colors.white,
                          splashColor: Colors.indigoAccent,
                          highlightColor: Colors.indigoAccent.withOpacity(0.5),
                          elevation: 10.0,
                          highlightElevation: 5.0,
                          onPressed: null,
                          child: new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Icon(Icons.play_arrow)
                          ), //Padding
                        ), //RawMaterialButton
                        new Expanded(child: new Container()),
                        new IconButton(
                            icon: new Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 35.0,
                            ), //Icon
                            onPressed: () {
                              //TODO
                            }), //IconButton
                        new Expanded(child: new Container()),
                      ], //<Widget>
                    ), //Row
                  ) //Padding
                ], //<Widget>
              ), //Column
            ), //Padding
          ) //Container
        ], //<Widget>
      ), //Column
    ); //Scaffold
  }
}

