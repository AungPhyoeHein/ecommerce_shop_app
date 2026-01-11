import 'package:bloc/bloc.dart';
import 'package:async/async.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/src/product/domain/usecases/get_product_by_id.dart';
import 'package:ecommerce_shop_app/src/product/domain/usecases/get_products.dart';
import 'package:ecommerce_shop_app/src/product/domain/usecases/search_products.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required GetProducts getProducts,
    required GetProductById getProductById,
    required SearchProducts searchProducts,
  }) : _getProducts = getProducts,
       _getProductById = getProductById,
       _searchProducts = searchProducts,
       super(ProductInitial());

  final GetProducts _getProducts;
  final GetProductById _getProductById;
  final SearchProducts _searchProducts;
  CancelableOperation? _currentOperation;

  Future<void> getProducts({
    required int page,
    required bool isRefresh,
    String? category,
    String? criteria,
  }) async {
    await _currentOperation?.cancel();
    if (page == 1) {
      if (criteria == "popular" && state is GotPopularProducts && !isRefresh) {
        return;
      }
      emit(const ProductLoading());
    } else if (state is GotProducts) {
      _emitNextPageLoading(page);
    }

    _currentOperation = CancelableOperation.fromFuture(
      _getProducts.call(
        GetProductsParams(
          page: page,
          category: category,
          criteria: criteria,
          isRefresh: isRefresh,
        ),
      ),
    );

    final result = await _currentOperation!.valueOrCancellation();

    if (result == null) return;

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (
      products,
    ) {
      if (criteria == "popular") {
        emit(
          GotPopularProducts(
            products: products,
            page: (products.length / NetworkConstants.pageSize).ceil(),
            isEnd: _isEndOfProducts(page, products.length),
          ),
        );
      } else if (category != null) {
        emit(
          GotFilteredProducts(
            products: products,
            page: (products.length / NetworkConstants.pageSize).ceil(),
            isEnd: _isEndOfProducts(page, products.length),
            selectedCategory: category,
          ),
        );
      } else {
        emit(
          GotProducts(
            products: products,
            page: (products.length / NetworkConstants.pageSize).ceil(),
            isEnd: _isEndOfProducts(page, products.length),
          ),
        );
      }
    });
  }

  Future<void> searchProducts({
    required int page,
    String? searchKey,
    String? category,
    bool isRefresh = false,
  }) async {
    if (page == 1) {
      emit(const ProductLoading());
    }

    final result = await _searchProducts.call(
      SearchProductsParams(
        page: page,
        category: category,
        searchKey: searchKey,
      ),
    );

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (
      products,
    ) {
      emit(
        GotProducts(
          products: products,
          page: page,
          isEnd: _isEndOfProducts(page, products.length),
        ),
      );
    });
  }

  Future<void> getProductsById(String id) async {
    emit(ProductLoading());
    final result = await _getProductById.call(id);

    result.fold(
      (failure) => emit(ProductError(failure.errorMessage)),
      (product) => emit(GotProduct(product)),
    );
  }

  void _emitNextPageLoading(int page) {
    if (state is GotProducts) {
      final currentState = state as GotProducts;
      emit(
        NextProductsLoading(
          page: page,
          products: currentState.products,
          isEnd: currentState.isEnd,
        ),
      );
    }
  }

  bool _isEndOfProducts(int page, int productsLength) {
    return productsLength < (page * NetworkConstants.pageSize);
  }
}
