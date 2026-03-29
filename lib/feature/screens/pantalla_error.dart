import 'package:flutter/material.dart';

class PantallaError extends StatelessWidget {
  const PantallaError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info, size: 48,
            ),
            Text(
              'El producto no se encuentra disponible',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}
