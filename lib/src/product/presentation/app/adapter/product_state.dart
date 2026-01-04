part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

//Initial State
final class ProductInitial extends ProductState {}

//Loading State
final class ProductLoading extends ProductState {
  const ProductLoading();
}

//Success State
final class GotProducts extends ProductState {
  const GotProducts(this.products);

  final List<Product> products;

  @override
  List<Object> get props => [products];
}

final class GotProduct extends ProductState {
  const GotProduct(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

//Error State
final class ProductError extends ProductState {
  const ProductError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
