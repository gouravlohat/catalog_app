import 'package:hive/hive.dart';
import '../models/product.dart';
import '../models/product.g.dart';

class HiveService {
  Future<void> initHive() async {
    Hive.registerAdapter(ProductAdapter());
    await Hive.openBox<Product>('products');
  }

  Box<Product> get productsBox => Hive.box<Product>('products');
}
