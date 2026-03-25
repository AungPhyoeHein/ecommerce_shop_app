import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/services/injection_container.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/src/cart/presentation/app/adapter/cart_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/product_detail_bottom_bar.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/product_detail_image_header.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/product_detail_info_container.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/product_detail_shimmer.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/product_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.hero,
    this.product,
    required this.productId,
  });

  final String hero;
  final Product? product;
  final String productId;

  static const path = "/products/";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedColor;
  String? selectedSize;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _initializeSelections(widget.product!);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _initializeSelections(Product product) {
    if (selectedColor == null && product.colors.isNotEmpty) {
      selectedColor = product.colors.first;
    }
    if (selectedSize == null && product.sizes.isNotEmpty) {
      selectedSize = product.sizes.first;
    }
  }

  Future<void> _loadInitialData() async {
    context.read<ProductCubit>().getProductsById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          CoreUtils.showSnackBar(context, message: state.message);
        } else if (state is CartItemAdded) {
          CoreUtils.showSnackBar(
            context,
            message: "Added to cart successfully",
          );
        }
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final product = state is GotProduct ? state.product : widget.product;
          if (product != null) {
            _initializeSelections(product);
          }

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      if (product != null)
                        ProductDetailImageHeader(
                          hero: widget.hero,
                          images: state is GotProduct
                              ? [state.product.image, ...state.product.images]
                              : [product.image],
                          product: product,
                        )
                      else
                        const ProductDetailImageHeaderShimmer(),
                      ProductDetailInfoContainer(
                        child: state is GotProduct
                            ? ProductDetailWidget(
                                product: state.product,
                                onColorSelected: (color) =>
                                    setState(() => selectedColor = color),
                                onSizeSelected: (size) =>
                                    setState(() => selectedSize = size),
                                onQuantityChanged: (qty) =>
                                    setState(() => quantity = qty),
                                initialQuantity: quantity,
                              )
                            : const ProductDetailShimmer(),
                      ),
                    ],
                  ),
                ),
                if (product != null)
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, cartState) {
                      return ProductDetailBottomBar(
                        isLoading: cartState is CartActionLoading,
                        isOutOfStock: product.countInStock <= 0,
                        onPressed: () {
                          context.read<CartCubit>().addToCart(
                            productId: product.id,
                            quantity: quantity,
                            selectedColor: selectedColor,
                            selectedSize: selectedSize,
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
