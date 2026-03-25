import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_card_info.dart';
import 'package:ecommerce_shop_app/core/widgets/cart_badge.dart';
import 'package:ecommerce_shop_app/src/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_shop_app/src/product/presentation/views/product_detail_screen.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:ecommerce_shop_app/src/wishlist/presentation/app/adapter/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const path = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Wishlist', style: TextStyles.headingSemiBold),
        actions: [
          CartBadge(
            child: IconButton(
              onPressed: () => context.push(CartScreen.path),
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: BlocConsumer<WishlistCubit, WishlistState>(
        listener: (context, state) {
          if (state is WishlistError) {
            CoreUtils.showSnackBar(context, message: state.message);
          }
        },
        builder: (context, state) {
          final user = context.watch<UserProvider>().currentUser;
          final wishlist = user?.wishList ?? [];

          if (state is WishlistLoading && wishlist.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wishlist.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyles.headingSemiBold.grey,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: wishlist.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final product = wishlist[index];
              return WishlistCard(product: product);
            },
          );
        },
      ),
    );
  }
}

class WishlistCard extends StatelessWidget {
  const WishlistCard({super.key, required this.product});

  final WishlistProduct product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: product.productExits
          ? () {
              context.push(
                '${ProductDetailScreen.path}${product.productId}',
                extra: {'product': product.toProduct()},
              );
            }
          : null,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CoreUtils.adaptiveColor(
            context,
            lightModeColor: MyColors.lightThemeStockColor,
            darkModeColor: MyColors.darkThemeDarkNavBarColor,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.productImage,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
                if (!product.productExits)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 15),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.paragraphSubTextRegular3
                        .adaptiveColor(context)
                        .copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: product.productExits
                              ? null
                              : TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.productExits
                        ? '\$${product.productPrice.toStringAsFixed(2)}'
                        : 'Unavailable',
                    style: product.productExits
                        ? TextStyles.paragraphSubTextRegular3.orange.copyWith(
                            fontWeight: FontWeight.w600,
                          )
                        : TextStyles.paragraphSubTextRegular3.grey,
                  ),
                ],
              ),
            ),
            // Remove Action
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24,
              ),
              onPressed: () {
                context
                    .read<WishlistCubit>()
                    .removeFromWishlist(product.productId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
