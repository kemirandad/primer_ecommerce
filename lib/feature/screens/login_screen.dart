import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce App', style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/productos'), 
          child: Text(
            'Entrar'    
          )
        ),
      ),
    );
  }
}
