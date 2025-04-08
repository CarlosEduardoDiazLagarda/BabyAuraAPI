import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obs = true;

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  // Función de registro
  Future<void> registerUser() async {
    if (nombreController.text.isEmpty ||
        apellidoController.text.isEmpty ||
        correoController.text.isEmpty ||
        usuarioController.text.isEmpty ||
        contrasenaController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Todos los campos son obligatorios"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
      return;
    }

    // Hacer la petición HTTP al servidor
    final response = await http.post(
      Uri.parse(
          'http://192.168.100.1/api/auth/register'), // Asegúrate de que este sea el endpoint correcto
      body: {
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'correo': correoController.text,
        'usuario': usuarioController.text,
        'contrasena': contrasenaController.text,
      },
    );

    // Verificar la respuesta del servidor
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success']) {
        // Si el registro es exitoso, navegar a la pantalla de Login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        _showErrorDialog(
            "Registro fallido. Intenta con otro usuario o correo.");
      }
    } else {
      _showErrorDialog("Error de conexión con el servidor.");
    }
  }

  // Mostrar un diálogo de error
  void _showErrorDialog(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // Construir el campo de texto con el icono y la funcionalidad
  Widget _buildTextField(
      String hint, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 3), blurRadius: 10, color: Colors.pink.shade300)
        ],
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        cursorColor: Colors.brown,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.brown.shade800),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BabyAura"),
        backgroundColor: Colors.yellow.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    Colors.white,
                    Color(0xffa3c4f9),
                    Color(0xfff6bfdd),
                  ],
                  stops: [0.3, 0.5, 0.6],
                ),
              ),
              child: Center(
                child: Lottie.asset("assets/animacion/baby.json",
                    height: 200, width: 200),
              ),
            ),
            _buildTextField("Nombre", nombreController, Icons.person),
            _buildTextField(
                "Apellido", apellidoController, Icons.person_outline),
            _buildTextField("Correo", correoController, Icons.email),
            _buildTextField("Usuario", usuarioController, Icons.account_circle),
            _buildTextField("Contraseña", contrasenaController, Icons.lock,
                obscure: true),
            GestureDetector(
              onTap:
                  registerUser, // Al hacer tap, ejecutará la función registerUser
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35, top: 25),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.pink.shade100],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child:
                    Text("REGISTRARSE", style: TextStyle(color: Colors.brown)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
