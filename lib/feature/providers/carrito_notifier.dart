import 'package:flutter/material.dart';
import 'package:primer_ecommerce/feature/models/item_carrito_model.dart';
import 'package:primer_ecommerce/feature/models/producto_model.dart';

class NewCarritoNotifier {
  final ValueNotifier<List<ItemCarritoModel>> state = ValueNotifier([]);

  // Lista de productos disponibles — datos fijos, viven aquí
  final List<ProductoModel> _catalogo = [
    ProductoModel(
      id: '1',
      nombre: 'Camisa',
      precio: 45000,
      stock: 34,
      color: Colors.red,
      icon: Icons.checkroom,
    ),
    ProductoModel(
      id: '2',
      nombre: 'Laptop',
      precio: 1500000,
      stock: 52,
      color: Colors.teal,
      icon: Icons.laptop,
    ),
    ProductoModel(
      id: '3',
      nombre: 'Café',
      stock: 23,
      precio: 12500,
      icon: Icons.coffee,
    ),
    ProductoModel(
      id: '4',
      nombre: 'Zapatos',
      stock: 124,
      precio: 89000,
      color: Colors.orange,
    ),
    // ...
  ];

  List<ProductoModel> get catalogo => _catalogo;

  List<ItemCarritoModel> get items => state.value;

  int get totalItems => items.length;

  double get totalPrecioCarrito => items.fold(0, (acc, item) => item.totalPrecioPorCantidad + acc);

  bool estaEnCarrito(String id) => items.any((p) => id == p.productoModel.id);

  void agregarProducto(ProductoModel p) {
    state.value = [
      ...state.value,
      ItemCarritoModel(productoModel: p, cantidad: 1),
    ];
  }

  int cantidadAgregadaProducto(String id) {
    final item = items.firstWhere((i) => id == i.productoModel.id);
    return item.cantidad;
  }

  void incrementar(String id) {
    state.value = items.map((i) {
      if (i.productoModel.id != id) return i;
      return i.copyWith(
        cantidad: (i.cantidad + 1).clamp(0, i.productoModel.stock),
      );
    }).toList();
  }

  void decrementar(String id) {
    final item = items.firstWhere((i) => i.productoModel.id == id);
    if (item.cantidad <= 1) {
      eliminar(id);
      return;
    }
    state.value = items.map((i) {
      if (i.productoModel.id != id) return i;
      return i.copyWith(cantidad: i.cantidad - 1);
    }).toList();
  }

  void eliminar(String id) {
    state.value = items.where((i) => i.productoModel.id != id).toList();
  }

  void vaciarCarrito() {
    state.value = [];
  }

  void dispose() => state.dispose();
}
