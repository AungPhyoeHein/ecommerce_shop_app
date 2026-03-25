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
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final product = wishlist[index];
              return WishlistTile(product: product);
            },
          );
        },
      ),
    );
  }
}

class WishlistTile extends StatelessWidget {
  const WishlistTile({super.key, required this.product});

  final WishlistProduct product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.productImage,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 60,
            height: 60,
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          ),
        ),
      ),
      title: Text(
        product.productExits
            ? product.productName
            : '${product.productName} (Not Available)',
        style: TextStyles.paragraphSubTextRegular3
            .adaptiveColor(context)
            .copyWith(
              color: product.productExits ? null : Colors.grey,
              decoration: product.productExits
                  ? null
                  : TextDecoration.lineThrough,
            ),
      ),
      subtitle: Text(
        product.productExits
            ? '\$${product.productPrice.toStringAsFixed(2)}'
            : 'This product is no longer available',
        style: product.productExits
            ? TextStyles.paragraphSubTextRegular3.orange
            : TextStyles.paragraphSubTextRegular3.grey,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: () {
          context.read<WishlistCubit>().removeFromWishlist(product.productId);
        },
      ),
      onTap: product.productExits
          ? () {
              context.push(
                '${ProductDetailScreen.path}${product.productId}',
                extra: {'product': product.toProduct()},
              );
            }
          : null,
    );
  }
}
