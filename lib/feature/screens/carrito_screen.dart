import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primer_ecommerce/feature/models/item_carrito_model.dart';
import 'package:primer_ecommerce/feature/providers/carrito_notifier_riverpod.dart';

class CarritoScreen extends ConsumerWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrito = ref.watch(carritoNotifier);
    final carritoProvider = ref.read(carritoNotifier.notifier);
    final total = ref.watch(carritoNotifier.notifier).totalPrecioCarrito();

    return Scaffold(  
      appBar: AppBar(
        title: const Text('Ecommerce App', style: TextStyle(fontSize: 24)),
      ),
      body: carrito.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Icon(Icons.info, size: 42),
                  Text(
                    'Ningún producto agregado',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    flex: 75,
                    child: ListView.builder(
                      itemCount: carrito.length,
                      itemBuilder: (context, index) {
                        final item = carrito[index];
                        return ItemCardWidget(
                          item: item,
                          onEliminarItem: () =>
                              carritoProvider.eliminar(item.productoModel.id),
                        );
                      },
                    ),
                  ),

                  Expanded(
                    flex: 25,
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(
                            'Valor total: \$${total.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => carritoProvider.vaciarCarrito(),
                            child: Text('Vaciar carrito'),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              final precioTotal = total;
                              carritoProvider.vaciarCarrito();
                              context.push('/carrito/checkout');
                            },
                            child: Text('Finalizar compra'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.item,
    required this.onEliminarItem,
  });

  final VoidCallback onEliminarItem;
  final ItemCarritoModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: item.productoModel.color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        visualDensity: VisualDensity.standard,
        leading: Icon(item.productoModel.icon),
        title: Text(item.productoModel.nombre),
        subtitle: Text(
          'Subtotal: \$${item.totalPrecioPorCantidad.toStringAsFixed(0)}',
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onEliminarItem,
              icon: Icon(Icons.delete),
            ),
            Text('${item.cantidad} ${item.cantidad > 1 ? 'unds' : 'und'}'),
          ],
        ),
      ),
    );
  }
}
