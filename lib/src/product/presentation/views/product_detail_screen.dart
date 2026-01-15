import 'package:ecommerce_shop_app/core/entities/product.dart';
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
    required this.product,
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    context.read<ProductCubit>().getProductsById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ProductDetailImageHeader(
                      hero: widget.hero,
                      images: state is GotProduct
                          ? [state.product.image, ...state.product.images]
                          : [widget.product!.image],
                    ),
                    ProductDetailInfoContainer(
                      child: state is GotProduct
                          ? ProductDetailWidget(product: state.product)
                          : const ProductDetailShimmer(),
                    ),
                  ],
                ),
              ),
              const ProductDetailBottomBar(),
            ],
          ),
        );
      },
    );
  }
}
