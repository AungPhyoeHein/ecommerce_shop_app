import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/error_image_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/shimmer_image_loading_widget.dart';
import 'package:ecommerce_shop_app/src/product/presentation/views/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatProductCard extends StatelessWidget {
  const ChatProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final String hero =
        GoRouterState.of(context).uri.toString() + 'chat_${product.id}';
    return GestureDetector(
      onTap: () {
        context.push(
          '${ProductDetailScreen.path}${product.id}',
          extra: {'product': product, 'hero': hero},
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: CoreUtils.adaptiveColor(
            context,
            lightModeColor: MyColors.lightThemeWhiteColor,
            darkModeColor: MyColors.darkThemeDarkNavBarColor,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.theme.primaryColor.withOpacity(0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Hero(
                  tag: hero,
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const ShimmerImageLoadingWidget(),
                    errorWidget: (context, error, stackTrace) =>
                        const ErrorImageWidget(),
                  ),
                ),
              ),
            ),
            // Details Section
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.paragraphSubTextRegular2
                          .copyWith(fontWeight: FontWeight.w600)
                          .adaptiveColor(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: TextStyles.paragraphSubTextRegular
                                  .copyWith(
                                    color:
                                        MyColors.lightThemeSecondaryTextColor,
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyles.headingSemiBold1.copyWith(
                                color: context.theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'View',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
