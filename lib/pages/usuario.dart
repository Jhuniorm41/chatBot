import 'package:flutter/material.dart';

import 'acerca.dart';
import 'manual.dart';

class Usuario extends StatefulWidget {
  @override
  UsuarioState createState() {
    return new UsuarioState();
  }
}

class UsuarioState extends State<Usuario> with TickerProviderStateMixin {
  var data;
  /// to build a reside menu drawer build by library



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // bannerAd?.dispose();
    super.dispose();
  }


  ///Lis-t of interview questions.
  Widget getListItems(Color color, IconData icon, String title) {
    return GestureDetector(
        child: Container(
          color: color,
          height: 335.0,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 100.0,
                    color: Colors.white,
                  ),
                  Text(
                    title, style: TextStyle(color: Colors.white)
                  )
                ],
              )),
        ),
        onTap: () async {
          if(title == "Como funciona AseSoft") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Manual(
                  title: title,
                )));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Acerca(
                  title: title,
                )));
          }
        }
      );
  }

  ///creating a carousel using carousel pro library.

  @override
  Widget build(BuildContext context) {
    //to use reside menu library we have to return a residemenu scafford.
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: new Text(
          'Acerca de',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
        //  getListItems(Color(0xFFF44336), Icons.chat, 'Como funciona AseSoft',),
//          getListItems(Color(0xFFFBC02D), Icons.settings, 'Configuraciones'),
          getListItems(Color(0xFF13B0A5), Icons.copyright, 'Sobre AseSoft'),
        ],
      ),
    );
  }
}
