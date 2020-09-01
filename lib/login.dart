import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'appBar.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Login extends StatefulWidget{
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login>{
  bool recordar = false;
  final _usrController = TextEditingController();
  final _passController = TextEditingController();
  GoogleSignInAccount _currentUser;
  String _contactText;

  // facebook
  void initiateFacebookLogin() async{
    var login = FacebookLogin();
    var result = await login.logInWithReadPermissions(['email']);
    switch(result.status) {

       case FacebookLoginStatus.loggedIn:
        print("true");
        getUser(result);
       break;
       case FacebookLoginStatus.error: print(result.errorMessage);
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => BottomNavBar()),
       );
       break;
       case FacebookLoginStatus.cancelledByUser: print("cancelado");
       break;
    }
  }
  void getUser(FacebookLoginResult result) async{
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    final profile = json.decode(graphResponse.body);
    print(profile['email']);
  }
  // Gmail
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }
  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

// normal
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    //verificar si se guardo el registro o identificador
    //pasar a la pantalla principal
  }
  Future login(BuildContext context) async{
    //verificar el usr y pass
    if(_usrController.text.length > 0 && _passController.text.length > 0){
//      final response = await http.get(Configuracion.host+"login/movil/${_usrController.text}/${_passController.text}");
//      print(response.statusCode);
//      if(response.statusCode == 200){
//        Map<String,dynamic> data = json.decode(response.body);
//        print(data);
//        if(data['sw']){
//          final prefs = await SharedPreferences.getInstance();
//          prefs.setInt('cliente_id',data['id'] );
//          prefs.setString('cliente_nombre',data['nombre'] );
//          prefs.setBool('cliente_log',true );
//          Navigator.pushNamed(context, '/home');
//        }
//      }
      print('usr=> ${_usrController.text}');
      print('pass=> ${_passController.text}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
//      if(_usrController.text == 'junior@gmail.com' && _passController.text == '123456') {
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => BottomNavBar()),
//        );
//      } else {}
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final textLogo = new Text('Diver Reposteria', textAlign: TextAlign.center, style: TextStyle(fontSize: 38),);
    final textLogoBy = new Text('by Rosanyela', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),);
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 70.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 80.0),
            textLogo,
            textLogoBy,
            SizedBox(height: 20.0),
            logo,
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usrController,
                    decoration: new InputDecoration(
                      labelText: "Usuario",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Contraseña",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(value:recordar,onChanged: (bool value){
                        setState(() {
                          recordar = value;
                        });
                      }),
                      Text('Recodar contraseña')
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    // height: double.infinity,
                    child: new RaisedButton(
                        onPressed: (){
                          login(context);
                        },
                        child: Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
                        color: Colors.purple,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)
                        )
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    // height: double.infinity,
                    child: new RaisedButton(
                        onPressed: (){
                          initiateFacebookLogin();
                        },
                        child: Text('Iniciar sesión con Facebook', style: TextStyle(color: Colors.blue)),
                        color: Colors.white,
//                        shape: new RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(20.0)
//                        )
                    ),
                  ),
                  SizedBox(height: 10.0),
//                  SizedBox(
//                    width: double.infinity,
//                    height: 50.0,
//                    // height: double.infinity,
//                    child: new RaisedButton(
//                        onPressed: (){
//                          _handleSignIn();
//                        },
//                        child: Text('Iniciar sesión con Gmail', style: TextStyle(color: Colors.white)),
//                        color: Colors.redAccent,
//                        shape: new RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(20.0)
//                        )
//                    ),
//                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
