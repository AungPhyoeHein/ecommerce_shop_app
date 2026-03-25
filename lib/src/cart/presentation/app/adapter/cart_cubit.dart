import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/src/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_shop_app/src/cart/domain/usecases/add_to_cart.dart';
import 'package:ecommerce_shop_app/src/cart/domain/usecases/get_cart.dart';
import 'package:ecommerce_shop_app/src/cart/domain/usecases/get_cart_count.dart';
import 'package:ecommerce_shop_app/src/cart/domain/usecases/modify_product_quantity.dart';
import 'package:ecommerce_shop_app/src/cart/domain/usecases/remove_from_cart.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required AddToCart addToCart,
    required GetCart getCart,
    required RemoveFromCart removeFromCart,
    required ModifyProductQuantity modifyProductQuantity,
    required GetCartCount getCartCount,
  }) : _addToCart = addToCart,
       _getCart = getCart,
       _removeFromCart = removeFromCart,
       _modifyProductQuantity = modifyProductQuantity,
       _getCartCount = getCartCount,
       super(const CartInitial());

  final AddToCart _addToCart;
  final GetCart _getCart;
  final RemoveFromCart _removeFromCart;
  final ModifyProductQuantity _modifyProductQuantity;
  final GetCartCount _getCartCount;

  Future<void> addToCart({
    required String productId,
    required int quantity,
    String? selectedSize,
    String? selectedColor,
  }) async {
    emit(const CartActionLoading());
    final result = await _addToCart(
      AddToCartParams(
        productId: productId,
        quantity: quantity,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
      ),
    );
    result.fold((failure) => emit(CartError(failure.errorMessage)), (cartItem) {
      emit(CartItemAdded(cartItem));
      getCart(); // Refresh cart list after addition
    });
  }

  Future<void> getCart() async {
    emit(const CartLoading());
    final result = await _getCart();
    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (cartItems) => emit(CartLoaded(cartItems)),
    );
  }

  Future<void> removeFromCart(String cartProductId) async {
    emit(const CartActionLoading());
    final result = await _removeFromCart(cartProductId);
    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (_) => getCart(), // Refresh cart after removal
    );
  }

  Future<void> modifyQuantity({
    required String cartProductId,
    required int quantity,
  }) async {
    // Note: In a real app, we might want optimistic updates here
    emit(const CartActionLoading());
    final result = await _modifyProductQuantity(
      ModifyProductQuantityParams(
        cartProductId: cartProductId,
        quantity: quantity,
      ),
    );
    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (_) => getCart(), // Refresh cart after quantity change
    );
  }

  Future<void> getCartCount() async {
    final result = await _getCartCount();
    result.fold((failure) => emit(CartError(failure.errorMessage)), (count) {
      // We might want a specific state for cart count if it's used globally
      // For now, let's just keep it simple
    });
  }
}
