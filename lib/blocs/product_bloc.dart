// blocs/product_bloc.dart
import 'package:catalog_app_task/services/hive_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';

import '../services/product_repository.dart';

abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class ProductState {
  final List<Product> products;
  final bool isLoading;

  ProductState({required this.products, required this.isLoading});
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HiveService hiveService = HiveService();
  final ProductRepository repository = ProductRepository();

  ProductBloc() : super(ProductState(products: [], isLoading: true)) {
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductState(products: [], isLoading: true));
      try {
        final products = await repository.fetchProducts();
        for (var product in products) {
          hiveService.productsBox.put(product.id, product);
        }
        emit(ProductState(products: products, isLoading: false));
      } catch (_) {
        emit(ProductState(
            products: hiveService.productsBox.values.toList(),
            isLoading: false));
      }
    });
  }
}
