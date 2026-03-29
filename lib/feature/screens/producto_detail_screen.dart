import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primer_ecommerce/feature/providers/carrito_notifier_riverpod.dart';


class ProductoDetailScreen extends ConsumerWidget {
  final String id;
  const ProductoDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cantidad = ref.watch(cantidadProductoProvider(id));
    final estaEnCarrito = ref.watch(estaEnCarritoProvider(id));
    final producto = ref.watch(catalogoProvider).firstWhere((p) => p.id == id);
    final carritoController = ref.read(carritoNotifier.notifier);
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Detalle de ${producto.nombre}')),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 35, child: Container(color: producto.color)),
      
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
                          Text(
                            producto.nombre,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${producto.precio.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 32),
                          ),
                          Text(
                            'Quedan ${producto.stock} disponibles',
                            style: TextStyle(fontSize: 20),
                          ),
      
                          Spacer(),
      
                          SizedBox(
                            width: ancho * 0.75,
                            child: !estaEnCarrito
                                ? ElevatedButton(
                                    onPressed: () => carritoController.agregarProducto(producto),
                                    child: Text('Agregar al carrito'),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    spacing: 20,
                                    children: [
                                      IconButton(
                                        onPressed: () => carritoController.decrementar(producto.id),
                                        icon: Icon(Icons.remove, size: 42),
                                      ),
                                      Text(
                                        '$cantidad',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => carritoController.incrementar(producto.id),
                                        icon: Icon(Icons.add, size: 42),
                                      ),
                                    ],
                                  ),
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
                  backgroundColor: producto.color.withValues(alpha: 0.5),
                  child: Icon(producto.icon, size: 60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
