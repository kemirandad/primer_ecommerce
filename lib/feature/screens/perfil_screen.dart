import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alto = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Perfil de usuario')),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 35, child: Container(color: Colors.blue)),

                Expanded(
                  flex: 65,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          const Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Text('johndoe@dev.com'),

                          const SizedBox(height: 12),

                          PerfilButtons(
                            nombre: 'Notificaciones',
                            icon: Icons.notifications,
                          ),

                          const SizedBox(height: 12),

                          PerfilButtons(
                            nombre: 'Privacidad',
                            icon: Icons.privacy_tip,
                          ),

                          const SizedBox(height: 12),

                          PerfilButtons(
                            nombre: 'Cerrar sesión',
                            icon: Icons.logout,
                            onCerrarSesion: () => context.go('/login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: alto * 0.25 - 75,
              left: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 75,
                child: CircleAvatar(
                  radius: 70,
                  child: Text('JD', style: TextStyle(fontSize: 40)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PerfilButtons extends StatelessWidget {
  final Color color;
  final String nombre;
  final IconData icon;
  final VoidCallback? onCerrarSesion;

  const PerfilButtons({
    super.key,
    this.color = Colors.black,
    required this.icon,
    required this.nombre, 
    this.onCerrarSesion,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: color),
        ),
        child: TextButton.icon(
          iconAlignment: IconAlignment.start,
          onPressed: onCerrarSesion ?? () {},
          label: Text(nombre),
          icon: Icon(icon),
        ),
      ),
    );
  }
}
