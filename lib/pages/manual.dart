import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Manual extends StatefulWidget {
  Manual({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Manual createState() => new _Manual();
}

class _Manual extends State<Manual> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Manual de Usuario", style: TextStyle(color: Colors.white)),
      ),
      body: new Column(children: <Widget>[
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          height: height / 1.12,
          child: myCarusel,
        ),
      ]),
    );
  }
}
final myCarusel = Carousel(
  dotSize: 5.0,
  dotIncreaseSize: 2.0,
  borderRadius: true,
  radius: Radius.circular(10.0),
  animationCurve: Curves.easeInOut,
  animationDuration: Duration(seconds: 15),
  images: [
    AssetImage('assets/images/a.jpeg'),
    AssetImage('assets/images/b.jpeg'),
    AssetImage('assets/images/c.jpeg'),
    AssetImage('assets/images/d.jpeg'),
    AssetImage('assets/images/e.jpeg'),
    AssetImage('assets/images/f.jpeg'),
  ],
);
final textLogo = new Text('AseSoft', textAlign: TextAlign.center, style: TextStyle(fontSize: 38),);
final textDes = new Text('AseSoft es una Inteligencia artificial, cual su proposito es poder ayudar a las personas a obtener cualquier '
    'información sobre los tramites, ya sean estos civiles, judiciales y otros.',
    textAlign: TextAlign.center, style: TextStyle(fontSize: 20));
