import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primer_ecommerce/feature/models/item_carrito_model.dart';
import 'package:primer_ecommerce/feature/models/producto_model.dart';

final catalogoProvider = Provider<List<ProductoModel>>((ref) {
  return [
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
  ];
});

// Provider que verifica si un producto está en el carrito
final estaEnCarritoProvider = Provider.family<bool, String>((ref, productoId) {
  final items = ref.watch(carritoNotifier);
  return items.any((i) => i.productoModel.id == productoId);
});

// Provider que retorna la cantidad de un producto específico
final cantidadProductoProvider = Provider.family<int, String>((ref, productoId) {
  final items = ref.watch(carritoNotifier);
  final item = items.where((i) => i.productoModel.id == productoId);
  return item.isEmpty ? 0 : item.first.cantidad;
});

final carritoNotifier = NotifierProvider<CarritoNotifier, List<ItemCarritoModel>>(
  CarritoNotifier.new,
);

class CarritoNotifier extends Notifier<List<ItemCarritoModel>> {
  @override
  List<ItemCarritoModel> build() => [];

  void agregarProducto(ProductoModel p) {
    state = [
      ...state,
      ItemCarritoModel(productoModel: p, cantidad: 1),
    ];
  }

  void incrementar(String id) {
    state = state.map((i) {
      if (i.productoModel.id != id) return i;
      return i.copyWith(
        cantidad: (i.cantidad + 1).clamp(0, i.productoModel.stock),
      );
    }).toList();
  }

  void decrementar(String id) {
    final item = state.firstWhere((i) => i.productoModel.id == id);
    if (item.cantidad <= 1) {
      eliminar(id);
      return;
    }
    state = state.map((i) {
      if (i.productoModel.id != id) return i;
      return i.copyWith(cantidad: i.cantidad - 1);
    }).toList();
  }

  void eliminar(String id) {
    state = state.where((i) => i.productoModel.id != id).toList();
  }

  void vaciarCarrito() {
    state = [];
  }

  double totalPrecioCarrito() {
    return state.fold(0, (acc, item) => item.productoModel.precio * item.cantidad + acc);
  }

}