import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class SearchProducts
    extends UsecaseWithParams<List<Product>, SearchProductsParams> {
  const SearchProducts(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<List<Product>> call(SearchProductsParams params) =>
      _repo.searchProducts(
        page: params.page,
        searchKey: params.searchKey,
        category: params.category,
      );
}

class SearchProductsParams extends Equatable {
  const SearchProductsParams({
    required this.page,
    this.searchKey,
    this.category,
  });
  final int page;
  final String? searchKey;
  final String? category;

  @override
  List<Object?> get props => [page, searchKey, category];
}
