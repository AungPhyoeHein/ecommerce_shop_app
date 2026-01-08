import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/filter_product_provider.dart';
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

  final _productsProvider = ProductsProvider.instance;
  final _popularProductProvider = PopularProductProvider.instance;
  final _filterProductProvider = FilterProductProvider.instance;

  Future<void> getProducts({
    required int page,
    String? category,
    String? criteria,
  }) async {
    if (page == 1) {
      if (criteria == "popular" &&
          (_popularProductProvider.popularProduct?.isNotEmpty ?? false)) {
        // Cache ရှိနေရင် Loading မပြတော့ဘဲ ရှိပြီးသား data ကိုပဲ emit လုပ်ပေးပါ
        emit(GotProducts(List.from(_popularProductProvider.popularProduct!)));
        return; // API ထပ်မခေါ်တော့ဘဲ ဒီမှာတင် ရပ်လိုက်ပါ
      }

      if (category == null &&
          criteria == null &&
          (_productsProvider.products?.isNotEmpty ?? false)) {
        emit(GotProducts(List.from(_productsProvider.products!)));
        return;
      }

      emit(const ProductLoading());
    }
    final result = await _getProducts.call(
      GetProductsParams(page: page, category: category, criteria: criteria),
    );

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (
      newProducts,
    ) {
      if (criteria == "popular") {
        if (page > 1) {
          _popularProductProvider.nextPage();
        }
        _popularProductProvider.addPopularProductList(newProducts);
        emit(
          GotProducts(List.from(_popularProductProvider.popularProduct ?? [])),
        );
      } else if (category == null && criteria == null) {
        _productsProvider.addProductList(newProducts);
        if (page > 1) {
          _productsProvider.nextPage();
        }
        emit(GotProducts(List.from(_productsProvider.products ?? [])));
      }
      if (newProducts.isEmpty) {}
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
    if (page == 1 || page == _filterProductProvider.currentPage) {
      if (_filterProductProvider.category != null &&
          category == _filterProductProvider.category) {
        emit(GotProducts(List.from(_filterProductProvider.filterProduct!)));
        return;
      }
      _filterProductProvider.clearFilterProductList();
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
      if (category != null) {
        if (page != 1) {
          _filterProductProvider.nextPage();
        }

        _filterProductProvider.addFilterProduct(newProducts, category);
        return emit(
          GotProducts(List.from(_filterProductProvider.filterProduct ?? [])),
        );
      }
    });
  }
}
