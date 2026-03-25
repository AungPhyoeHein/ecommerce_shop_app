import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/error_image_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/shimmer_image_loading_widget.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/login_screen.dart';
import 'package:ecommerce_shop_app/src/wishlist/presentation/app/adapter/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductCardImage extends StatelessWidget {
  const ProductCardImage(this.product, this.hero, {super.key});
  final Product product;
  final String hero;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          Hero(
            tag: hero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const ShimmerImageLoadingWidget(),
                errorWidget: (context, error, stackTrace) =>
                    const ErrorImageWidget(),
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: BlocConsumer<WishlistCubit, WishlistState>(
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

                return GestureDetector(
                  onTap: () {
                    if (user == null) {
                      context.push(LoginScreen.path);
                      return;
                    }
                    if (isFavorite) {
                      context.read<WishlistCubit>().removeFromWishlist(
                        product.id,
                      );
                    } else {
                      context.read<WishlistCubit>().addToWishlist(product);
                    }
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white.withOpacity(0.7),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: isFavorite ? Colors.red : Colors.black54,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
