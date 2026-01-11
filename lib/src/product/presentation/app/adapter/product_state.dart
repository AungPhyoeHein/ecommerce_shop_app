part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();

  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  List<Object?> get props => [];
}

class NextProductsLoading extends GotProducts {
  const NextProductsLoading({
    required super.products,
    required super.page,
    required super.isEnd,
  });

  @override
  List<Object?> get props => [];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object?> get props => [message];
}

final class GotProduct extends ProductState {
  const GotProduct(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

class GotProducts extends ProductState {
  final List<Product> products;
  final int page;
  final bool isEnd;

  const GotProducts({
    required this.products,
    required this.page,
    required this.isEnd,
  });

  @override
  List<Object?> get props => [products, page, isEnd];
}

class GotPopularProducts extends GotProducts {
  const GotPopularProducts({
    required super.products,
    required super.page,
    required super.isEnd,
  });
}

class GotFilteredProducts extends GotProducts {
  final String? selectedCategory;
  const GotFilteredProducts({
    required super.products,
    required super.page,
    required super.isEnd,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [products, page, isEnd, selectedCategory];
}
