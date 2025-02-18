import 'package:hive/hive.dart';
import 'product.dart';

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    return Product(
      id: reader.read(),
      title: reader.read(),
      description: reader.read(),
      price: reader.read(),
      image: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.price);
    writer.write(obj.image);
  }
}
