import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/src/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_shop_app/src/cart/presentation/app/adapter/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const path = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Cart', style: TextStyles.headingSemiBold),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            CoreUtils.showSnackBar(context, message: state.message);
          } else if (state is CartLoaded) {
            setState(() {
              _cartItems = state.cartItems;
            });
          }
        },
        builder: (context, state) {
          if (state is CartLoading && _cartItems.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const Gap(16),
                  Text(
                    'Your cart is empty',
                    style: TextStyles.headingSemiBold.grey,
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _cartItems.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return CartTile(item: item);
                      },
                    ),
                  ),
                  CartSummary(cartItems: _cartItems),
                ],
              ),
              if (state is CartActionLoading)
                Container(
                  color: Colors.black.withOpacity(0.1),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.productImage,
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
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: TextStyles.paragraphRegular.adaptiveColor(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.selectedSize != null || item.selectedColor != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        if (item.selectedSize != null)
                          Text(
                            item.selectedSize!,
                            style: TextStyles.paragraphSubTextRegular.grey,
                          ),
                        if (item.selectedSize != null &&
                            item.selectedColor != null)
                          const Gap(8),
                        if (item.selectedColor != null)
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: item.selectedColor!.toColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 0.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                const Gap(8),
                Text(
                  '\$${item.productPrice.toStringAsFixed(2)}',
                  style: TextStyles.headingMedium4.orange,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 20,
                ),
                onPressed: () {
                  context.read<CartCubit>().removeFromCart(item.id);
                },
              ),
              const Gap(12),
              Row(
                children: [
                  _QuantityButton(
                    icon: Icons.remove,
                    onPressed: item.quantity > 1
                        ? () {
                            context.read<CartCubit>().modifyQuantity(
                              cartProductId: item.id,
                              quantity: item.quantity - 1,
                            );
                          }
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${item.quantity}',
                      style: TextStyles.paragraphRegular.adaptiveColor(context),
                    ),
                  ),
                  _QuantityButton(
                    icon: Icons.add,
                    onPressed: () {
                      context.read<CartCubit>().modifyQuantity(
                        cartProductId: item.id,
                        quantity: item.quantity + 1,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 16,
          color: onPressed == null ? Colors.grey : null,
        ),
      ),
    );
  }
}

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    final total = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.productPrice * item.quantity),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CoreUtils.adaptiveColor(
          context,
          lightModeColor: MyColors.lightThemeWhiteColor,
          darkModeColor: MyColors.darkThemeDarkNavBarColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyles.headingMedium3.adaptiveColor(context),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyles.headingMedium3.orange,
                ),
              ],
            ),
            const Gap(16),
            RoundedButton(
              text: 'Checkout',
              onPressed: () {
                // TODO: Implement checkout
                CoreUtils.showSnackBar(
                  context,
                  message: 'Checkout not implemented yet',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
