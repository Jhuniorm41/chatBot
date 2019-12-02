import 'package:flutter/material.dart';
import 'appBar.dart';

class Login extends StatefulWidget{
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login>{
  bool recordar = false;
  final _usrController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //verificar si se guardo el registro o identificador
    //pasar a la pantalla principal
  }
  Future login(BuildContext context) async{
    //verificar el usr y pass
//    if(_usrController.text.length > 0 && _passController.text.length > 0){
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
//    }

    print('usr=> ${_usrController.text}');
    print('pass=> ${_passController.text}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final textLogo = new Text('AseSoft', textAlign: TextAlign.center, style: TextStyle(fontSize: 38),);
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
            logo,
            SizedBox(height: 20.0),
            textLogo,
            SizedBox(height: 50.0),
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
                      labelText: "Password",
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
                        color: Colors.cyan,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)
                        )
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}