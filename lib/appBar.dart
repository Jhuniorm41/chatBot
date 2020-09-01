import 'package:AseSoft/pages/home.dart';
import 'package:AseSoft/pages/usuario.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'pages/chat.dart';
import 'pages/acerca.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 1;

  final HomePageDialogflow chat = new HomePageDialogflow();
  final Home home = new Home();
  final Usuario usuario = new Usuario();
  final Acerca acerca = new Acerca();

  Widget _showPage = new Home();
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0: return chat;
      break;
      case 1: return home;
      break;
      case 2: return acerca;
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.chat, size: 30, color: Colors.white),
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.copyright, size: 30, color: Colors.white),

//            Icon(Icons.call_split, size: 30),
//            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.purple,
          buttonBackgroundColor: Colors.purple,
          backgroundColor: Colors.white,
          animationCurve: Curves.decelerate,
          animationDuration: Duration(milliseconds: 300),
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}