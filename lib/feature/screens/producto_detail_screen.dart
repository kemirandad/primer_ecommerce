import 'package:flutter/material.dart';
import 'package:primer_ecommerce/feature/models/producto_model.dart';
import 'package:primer_ecommerce/feature/providers/carrito_provider.dart';


class ProductoDetailScreen extends StatelessWidget {
  final ProductoModel producto;
  const ProductoDetailScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Detalle de ${producto.nombre}')),
      body: ValueListenableBuilder(
        valueListenable: carritoProvider.state,
        builder: (context, value, child) => SafeArea(
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
                              child: !carritoProvider.estaEnCarrito(producto.id)
                                  ? ElevatedButton(
                                      onPressed: () => carritoProvider
                                          .agregarProducto(producto),
                                      child: Text('Agregar al carrito'),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 20,
                                      children: [
                                        IconButton(
                                          onPressed: () => carritoProvider
                                              .decrementar(producto.id),
                                          icon: Icon(Icons.remove, size: 42),
                                        ),
                                        Text(
                                          '${carritoProvider.cantidadAgregadaProducto(producto.id)}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => carritoProvider
                                              .incrementar(producto.id),
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
      ),
    );
  }
}
