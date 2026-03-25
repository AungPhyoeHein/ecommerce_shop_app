import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/src/cart/presentation/app/adapter/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBadge extends StatefulWidget {
  const CartBadge({super.key, required this.child});

  final Widget child;

  @override
  State<CartBadge> createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  int _lastCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          _lastCount = state.cartItems.fold(
            0,
            (sum, item) => sum + item.quantity,
          );
        }

        if (_lastCount == 0) return widget.child;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            widget.child,
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: MyColors.lightThemePrimaryColor,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Center(
                  child: Text(
                    _lastCount > 9 ? '9+' : '$_lastCount',
                    style: TextStyles.paragraphSubTextRegular.white.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
