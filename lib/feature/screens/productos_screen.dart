import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primer_ecommerce/feature/models/producto_model.dart';
import 'package:primer_ecommerce/feature/providers/carrito_notifier_riverpod.dart';


class ProductosScreen extends ConsumerWidget {
  const ProductosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogo = ref.watch(catalogoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce App', style: TextStyle(fontSize: 24)),
      ),
      body: GridView.builder(
            itemCount: catalogo.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 4,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final producto = catalogo[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => context.push('/productos/detail/${producto.id}'),
                  child: ProductoCardWidget(
                    producto: producto,
                  ),
                ),
              );
            },
          )
    );
  }
}

class ProductoCardWidget extends ConsumerWidget {
  final ProductoModel producto;


  const ProductoCardWidget({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estaEnCarrito = ref.watch(estaEnCarritoProvider(producto.id));
    final carritoController = ref.read(carritoNotifier.notifier);
    final cantidad = ref.watch(cantidadProductoProvider(producto.id));

    return Container(
      decoration: BoxDecoration(
        color: producto.color.withValues(alpha: 0.2),
        border: Border.all(width: 2, color: producto.color),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, offset: Offset(-4, 4)),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              producto.nombre,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${producto.precio.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16),
            ),

            !estaEnCarrito
                ? ElevatedButton.icon(
                    onPressed: () => carritoController.agregarProducto(producto),
                    label: Text('Agregar'),
                    icon: Icon(Icons.add),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      IconButton(
                        onPressed: () => carritoController.decrementar(producto.id),
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        '$cantidad',
                      ),
                      IconButton(
                        onPressed: () => carritoController.incrementar(producto.id),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
