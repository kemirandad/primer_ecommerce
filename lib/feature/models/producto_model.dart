import 'package:flutter/material.dart';

class ProductoModel {
  final String id;
  final String nombre;
  final double precio;
  final int stock;
  final Color color;
  final IconData icon;

  const ProductoModel({
    required this.id,
    required this.nombre,
    required this.precio,
    this.color = Colors.blue,
    this.icon = Icons.question_mark,
    this.stock = 0,
  });

  ProductoModel copyWith({int? stock}) => ProductoModel(
    id: id,
    nombre: nombre,
    precio: precio,
    stock: stock ?? this.stock,
  );

  double get totalPorProducto => stock * precio;
}
