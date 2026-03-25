import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/login_screen.dart';
import 'package:ecommerce_shop_app/core/widgets/cart_badge.dart';
import 'package:ecommerce_shop_app/src/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/product_image_slider.dart';
import 'package:ecommerce_shop_app/src/wishlist/presentation/app/adapter/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductDetailImageHeader extends StatelessWidget {
  const ProductDetailImageHeader({
    super.key,
    required this.hero,
    required this.images,
    required this.product,
  });

  final String hero;
  final List<String> images;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Stack(
        children: [
          Hero(
            tag: hero,
            child: ProductImageSlider(images: images),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            right: 20,
            child: Row(
              children: [
                CartBadge(
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () => context.push(CartScreen.path),
                    ),
                  ),
                ),
                const Gap(10),
                BlocConsumer<WishlistCubit, WishlistState>(
                  listener: (context, state) {
                    if (state is WishlistError) {
                      CoreUtils.showSnackBar(context, message: state.message);
                    }
                  },
                  builder: (context, state) {
                    final user = context.watch<UserProvider>().currentUser;
                    final isFavorite =
                        user?.wishList.any(
                          (element) => element.productId == product.id,
                        ) ??
                        false;

                    return CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          if (user == null) {
                            context.push(LoginScreen.path);
                            return;
                          }
                          if (isFavorite) {
                            context.read<WishlistCubit>().removeFromWishlist(
                              product.id,
                            );
                          } else {
                            context.read<WishlistCubit>().addToWishlist(
                              product,
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
