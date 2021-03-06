import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Acerca extends StatefulWidget {
  Acerca({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Acerca createState() => new _Acerca();
}

class _Acerca extends State<Acerca> {

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 70.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: new Text("Acerca de Diver", style: TextStyle(color: Colors.white)),
      ),
      body: new Column(children: <Widget>[
        SizedBox(height: 80.0),
        logo,
        SizedBox(height: 80.0),
        textLogo,
        SizedBox(height: 40.0),
        textDes,
        SizedBox(height: 10.0),
        textAC,
        new Divider(height: 2.0),
        textAW,

        SizedBox(
          width: double.infinity,
          height: 50.0,
          // height: double.infinity,
          child: new IconButton(
            icon: Icon(Icons.link),
            color: Colors.purple,
            onPressed: _launchURL,
          ),
        ),



        textIr,
      ]),
    );
  }
}

_launchURL() async {
  const url = 'https://jhuniorm41.wixsite.com/asesoft';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
final textLogo = new Text('Diver', textAlign: TextAlign.center, style: TextStyle(fontSize: 38),);
final textDes = new Text('Diver es desarrollado por:',
    textAlign: TextAlign.left, style: TextStyle(fontSize: 25));
final textAC = new Text('Rosanyela Hurtado Rico',
    textAlign: TextAlign.center, style: TextStyle(fontSize: 20));
final textAW = new Text('Ingenieria de Software I',
    textAlign: TextAlign.center, style: TextStyle(fontSize: 20));

final textIr = new Text('Ir a web',
    textAlign: TextAlign.center, style: TextStyle(fontSize: 20));
