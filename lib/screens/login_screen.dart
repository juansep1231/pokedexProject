import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/main.dart';
import 'package:pokedex_mobile/screens/category_screen.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../widgets/alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image(
                  image: NetworkImage(
                      'https://cloudfront-us-east-1.images.arcpublishing.com/elcomercio/P7KP35OZHRAKTGNKQU4R5ANHIU.jpg'),
                ),
              ),
              TextField(
                controller: _mailController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: () {
                      provider.signInUserPassword(
                          _mailController.text, _passwordController.text);
                      if (provider.user != null) {
                        print("Usuario ingresado correctamente");
                        Navigator.pushNamed(context, MainWidget.routeName);
                      } else {
                        _showLoginErrorDialog(context);
                      }
                    },
                    child: const Text('Iniciar Sesión'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertLoginError();
      },
    );
  }
}
