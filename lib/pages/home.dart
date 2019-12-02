import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Home createState() => new _Home();
}

class _Home extends State<Home> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Bienvenido"),
      ),
      body: new Column(children: <Widget>[
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          height: height / 2.1,
          child: myCarusel,
        ),
        new Divider(height: 1.0),
        textLogo,
        new Divider(height: 2.0),
        textDes,
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
  animationDuration: Duration(seconds: 2),
  images: [
    AssetImage('assets/images/card1.png'),
    AssetImage('assets/images/card3.png'),
    AssetImage('assets/images/card4.png'),
    AssetImage('assets/images/card2.png'),
  ],
);
final textLogo = new Text('AseSoft', textAlign: TextAlign.center, style: TextStyle(fontSize: 38),);
final textDes = new Text('AseSoft es una Inteligencia artificial, cual su proposito es poder ayudar a las personas a obtener cualquier '
    'información sobre los tramites, ya sean estos civiles, judiciales y otros.',
    textAlign: TextAlign.center, style: TextStyle(fontSize: 20));
