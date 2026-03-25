import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primer_ecommerce/feature/models/producto_model.dart';
import 'package:primer_ecommerce/feature/providers/carrito_provider.dart';


class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce App', style: TextStyle(fontSize: 24)),
      ),
      body: ValueListenableBuilder(
        valueListenable: carritoProvider.state,
        builder: (context, itemsCarrito, child) {
          return GridView.builder(
            itemCount: carritoProvider.catalogo.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 4,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final producto = carritoProvider.catalogo[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => context.push('/productos/detail/${producto.id}', extra: producto),
                  child: ProductoCardWidget(
                    producto: producto,
                    onCantidadAgregadaPorProducto: (String id) =>
                        carritoProvider.cantidadAgregadaProducto(producto.id),
                    onEstaEnCarrito: (String id) =>
                        carritoProvider.estaEnCarrito(producto.id),
                    onAgregar: () => carritoProvider.agregarProducto(producto),
                    onIncrementar: () =>
                        carritoProvider.incrementar(producto.id),
                    onDecrementar: () =>
                        carritoProvider.decrementar(producto.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductoCardWidget extends StatelessWidget {
  final ProductoModel producto;
  final VoidCallback onAgregar;
  final VoidCallback onDecrementar;
  final VoidCallback onIncrementar;
  final bool Function(String id) onEstaEnCarrito;
  final int Function(String id) onCantidadAgregadaPorProducto;


  const ProductoCardWidget({
    super.key,
    required this.producto,
    required this.onAgregar,
    required this.onIncrementar,
    required this.onDecrementar,
    required this.onEstaEnCarrito,
    required this.onCantidadAgregadaPorProducto
  });

  @override
  Widget build(BuildContext context) {
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

            !onEstaEnCarrito(producto.id)
                ? ElevatedButton.icon(
                    onPressed: onAgregar,
                    label: Text('Agregar'),
                    icon: Icon(Icons.add),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      IconButton(
                        onPressed: onDecrementar,
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        '${onCantidadAgregadaPorProducto(producto.id)}',
                      ),
                      IconButton(
                        onPressed: onIncrementar,
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
