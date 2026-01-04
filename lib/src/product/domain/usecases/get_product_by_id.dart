import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';

class GetProductById extends UsecaseWithParams<Product, String> {
  const GetProductById(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<Product> call(String id) => _repo.getProductById(id);
}
