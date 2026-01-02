import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

abstract class ProductRepostory {
  const ProductRepostory();

  ResultFuture<List<Product>> getProducts();

  ResultFuture<Product> getProductById(String id);

  ResultFuture<List<Product>> searchProducts(String query);
}
