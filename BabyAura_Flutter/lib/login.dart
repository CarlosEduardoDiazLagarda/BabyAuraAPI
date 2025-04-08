import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'RegisterScreen.dart';
import 'InicioScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obs = true;

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'Campos vacíos',
        desc: 'Por favor completa todos los campos',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'https://3eb1-2806-2f0-2220-f187-9f-ab66-1a78-35b.ngrok-free.app/api/auth/login'), // URL de tu API
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': idController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['success'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InicioScreen()),
          );
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: 'Login incorrecto',
            desc: 'Credenciales inválidas',
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Error del servidor',
          desc: 'No se pudo conectar con el servidor',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Error inesperado',
        desc: 'Ocurrió un error: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.blueAccent.shade100,
              Colors.yellow,
              Color(0xffeb75b6),
            ],
            stops: [0.3, 0.5, 0.6],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 550,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 20,
                      color: Colors.lightBlue.shade300,
                    )
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Lottie.asset("assets/animacion/baby.json"),
                        height: 200,
                        width: 200,
                      ),
                      // CAMPO ID
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 20,
                              color: Colors.lightBlue.shade300,
                            )
                          ],
                        ),
                        child: TextField(
                          controller: idController,
                          cursorColor: Colors.brown,
                          decoration: InputDecoration(
                            icon: Icon(Icons.admin_panel_settings,
                                color: Colors.brown.shade800),
                            hintText: "ID",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // CAMPO CONTRASEÑA
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 25),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 20,
                              color: Colors.lightBlue.shade300,
                            )
                          ],
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: obs,
                          cursorColor: Colors.brown,
                          decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key,
                                color: Colors.brown.shade800),
                            hintText: "Contraseña",
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obs ? Icons.visibility : Icons.visibility_off,
                                color: Colors.brown.shade800,
                              ),
                              onPressed: () {
                                setState(() {
                                  obs = !obs;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // BOTÓN ACCEDER
                      GestureDetector(
                        onTap: loginUser,
                        child: Container(
                          margin: EdgeInsets.only(left: 35, right: 35, top: 25),
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.lightBlue.shade100,
                                Colors.blue.shade300,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "ACCEDER",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ),
                      ),
                      // REGISTRARSE
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 35, right: 35, top: 25),
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.yellow, Colors.pink.shade100],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "REGISTRARSE",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
