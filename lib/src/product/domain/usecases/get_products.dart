import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class GetProducts extends UsecaseWithParams<List<Product>, GetProductsParams> {
  const GetProducts(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<List<Product>> call(GetProductsParams params) =>
      _repo.getProducts(
        page: params.page,
        category: params.category,
        criteria: params.criteria,
      );
}

class GetProductsParams extends Equatable {
  const GetProductsParams({required this.page, this.category, this.criteria});

  final int page;
  final String? category;
  final String? criteria;

  @override
  List<Object?> get props => [page, category, criteria];
}
