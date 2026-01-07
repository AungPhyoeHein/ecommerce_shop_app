import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/popular_product_provider.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/products_provider.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
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

  List<Product> allProducts = [];
  List<Product> searchedProducts = [];
  final _productsProvider = ProductsProvider.instance;
  final _popularProductProvider = PopularProductProvider.instance;

  Future<void> getProducts({
    required int page,
    String? category,
    String? criteria,
  }) async {
    if (page == 1) {
      if (criteria == "popular" &&
          _popularProductProvider.popularProduct != null &&
          _popularProductProvider.popularProduct!.isNotEmpty) {
        emit(GotProducts(List.from(_popularProductProvider.popularProduct!)));
        return;
      } else if (category == null &&
          criteria == null &&
          _productsProvider.products != null &&
          _productsProvider.products!.isNotEmpty) {
        emit(GotProducts(List.from(_productsProvider.products!)));
        return;
      }

      allProducts.clear();
      emit(const ProductLoading());
    }

    if (_productsProvider.currentPage == page) {
      if (category == null &&
          criteria == null &&
          _productsProvider.products != null &&
          _productsProvider.products!.isNotEmpty) {
        emit(GotProducts(List.from(_productsProvider.products!)));
        return;
      }
    }

    final result = await _getProducts.call(
      GetProductsParams(page: page, category: category, criteria: criteria),
    );

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (
      newProducts,
    ) {
      if (criteria == "popular") {
        _popularProductProvider.addPopularProductList(newProducts);
        emit(
          GotProducts(List.from(_popularProductProvider.popularProduct ?? [])),
        );
      } else if (category == null && criteria == null) {
        _productsProvider.addProductList(newProducts);
        emit(GotProducts(List.from(_productsProvider.products ?? [])));
      } else {
        allProducts.addAll(newProducts);
        emit(GotProducts(List.from(allProducts)));
      }
    });
  }

  Future<void> getProductsById(String id) async {
    emit(const ProductLoading());
    final result = await _getProductById.call(id);

    result.fold(
      (failure) => emit(ProductError(failure.errorMessage)),
      (product) => emit(GotProduct(product)),
    );
  }

  Future<void> searchProducts({
    required int page,
    String? searchKey,
    String? category,
  }) async {
    if (page == 1) {
      searchedProducts.clear();
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
      newProducts,
    ) {
      searchedProducts.addAll(newProducts);
      emit(GotProducts(List.from(searchedProducts)));
    });
  }
}
