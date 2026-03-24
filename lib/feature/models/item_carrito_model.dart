import 'package:primer_ecommerce/feature/models/producto_model.dart';

class ItemCarritoModel {
  final ProductoModel productoModel;
  final int cantidad;

  const ItemCarritoModel({required this.productoModel, required this.cantidad});

  ItemCarritoModel copyWith({int? cantidad}) => ItemCarritoModel(
    productoModel: productoModel,
    cantidad: cantidad ?? this.cantidad,
  );

  double get totalPrecioPorCantidad => productoModel.precio * cantidad;
}
