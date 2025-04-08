import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class BottomNavigationBar with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class _InicioScreenState extends State<InicioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BabyAura"),
        backgroundColor: Colors.grey.shade100,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [
              Colors.white,
              Color(0xff96d0ff), // Azul claro
            ],
            stops: [0.4, 7],
          ),
        ),
      ),
      drawer: Drawer(
          child: new ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Nombre"),
            accountEmail: Text("email@prueba.es"),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.white),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Acerca de'),
            leading: Icon(Icons.home),
          ),
          ListTile(
            title: Text('Cerrar Sesion'),
            leading: Icon(Icons.settings),
          ),
        ],
      )),
    );
  }
}
