import 'package:flutter/material.dart';

class AlertLoginError extends StatelessWidget {
  const AlertLoginError({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text('Error al iniciar sesion'),
      actions: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar')),
        )
      ],
    );
  }
}
